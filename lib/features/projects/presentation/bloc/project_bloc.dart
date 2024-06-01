import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tg_freelance/core/constants/directus_collections.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/router/navigation_service.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/projects/data/models/project_data_model.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_state.dart';
import 'package:tg_freelance/features/user/domain/lite_user_entity.dart';
import 'package:tg_freelance/features/user/domain/user_entity.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';

part 'project_event.dart';

final projectBloc = getIt<ProjectBloc>();

@Singleton()
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc()
      : super(const ProjectMainState(
            status: Status.initial,
            available: [],
            userResponses: [],
            usersProjects: [])) {
    on<ProjectCreateNew>(_createNew);
    on<ProjectFetchProjects>(_fetchProjects);
    on<ProjectOpenProject>(_openProject);
    on<ProjectSubmitProposal>(_submitProposal);
  }

  FutureOr<void> _createNew(
      ProjectCreateNew event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final ProjectDataModel model = event.project.toModel();
    final res = await directus.createOne(
        collection: DirectusCollections.projectsCollection,
        data: model.toMap());

    final updProj = ProjectDataModel.fromMap(res).toEntity();
    List<ProjectEntity> userProjects = List.from(state.usersProjects);
    userProjects.add(updProj);

    emit(state.copyWith(status: Status.success, usersProjects: userProjects));
    navigationService.config.pop();
    log('User projects: ${userProjects.length}');
  }

  FutureOr<void> _fetchProjects(
      ProjectFetchProjects event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: Status.loading));
    List<ProjectEntity> myProjects = [];
    List<ProjectEntity> available = [];
    final all = await directus.readMany(
        collection: DirectusCollections.projectsCollection);

    for (var map in all) {
      final maps =
          await fetchProposals(List.from(map['proposals']).cast<int>());
      map['proposals'] = maps;
    }

    List<ProjectEntity> allEnts = all.map((el) {
      return ProjectDataModel.fromMap(el).toEntity();
    }).toList();

    for (ProjectEntity ent in allEnts) {
      if (ent.authorId == userbloc.state.authorizedUser.dirId.toString()) {
        myProjects.add(ent);
      } else {
        available.add(ent);
      }
    }

    emit(state.copyWith(
      usersProjects: myProjects,
      status: Status.initial,
      available: available,
    ));
  }

  Future<List<Map<String, dynamic>>> fetchProposals(List<int> ids) async {
    List<Map<String, dynamic>> res = [];
    for (var id in ids) {
      final raw = await directus.readOne(
          collection: DirectusCollections.proposalsCollections,
          id: id.toString());
      res.add(raw);
    }
    return res;
  }

  FutureOr<void> _openProject(
      ProjectOpenProject event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: Status.loading));
    UserEntity authorized = userbloc.state.authorizedUser;
    LiteUserEntity author;

    if (event.entity.authorId != authorized.dirId.toString()) {
      final rawAuthor = await directus.readOne(
        collection: DirectusCollections.usersCollection,
        id: event.entity.authorId,
      );
      author = LiteUserEntity.fromMap(rawAuthor);
    } else {
      author = LiteUserEntity(
          dirId: authorized.dirId,
          userName: authorized.userName,
          userPicUrl: '',
          amountOfProjects: state.usersProjects.length);
    }

    final rawPrj = await directus.readOne(
        collection: DirectusCollections.projectsCollection,
        id: event.entity.dirId);
    List<int> rawIds = List.from(rawPrj['proposals']).cast<int>();

    if (rawIds.length != event.entity.proposals?.length) {
      Set<int> rawSet = rawIds.toSet();
      List<int> fresh = [];
      List<ProposalEntity> props = [];

      if (event.entity.proposals?.isNotEmpty ?? false) {
        for (ProposalEntity prop in event.entity.proposals!) {
          if (!rawSet.contains(prop.dirId)) {
            fresh.add(prop.dirId);
          }
        }
      } else {
        fresh.addAll(rawSet.toList());
      }
      final maps = await fetchProposals(fresh);
      for (var map in maps) {
        props.add(ProposalEntity.fromMap(map));
      }
      event.entity.copyWith(proposals: props);
    }

    navigationService.config.push(
      AppRoutes.projectPage.path,
      extra: ProjectPageData(
        entity: event.entity,
        author: author,
        isMe: event.entity.authorId == authorized.dirId.toString(),
      ),
    );

    //TODO implement proposals fetch

    emit(state.copyWith(status: Status.initial));
  }

  FutureOr<void> _submitProposal(
      ProjectSubmitProposal event, Emitter<ProjectState> emit) async {
    final UserEntity user = userbloc.state.authorizedUser;
    final ProposalEntity proposalEntity = ProposalEntity(
      dirId: 0,
      authorId: user.dirId,
      authorName: user.userName,
      coverLetter: event.coverLetter,
      date: DateTime.now(),
      projectId: event.projectId,
    );
    final raw = await directus.createOne(
      collection: DirectusCollections.proposalsCollections,
      data: proposalEntity.toMap(),
    );
    navigationService.config.pop();
    log(raw.toString());
  }
}
