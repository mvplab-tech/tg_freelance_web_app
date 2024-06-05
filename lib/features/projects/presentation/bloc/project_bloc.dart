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
    on<EditProjectEvent>(_editProject);
    on<DeleteProject>(_deleteProject);
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
    List<ProjectEntity> myReposnes = [];

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
      int userId = userbloc.state.authorizedUser.dirId;
      if (ent.authorId == userId.toString()) {
        myProjects.add(ent);
      } else {
        available.add(ent);
      }

      if (ent.proposals != null) {
        for (ProposalEntity prop in ent.proposals!) {
          if (prop.authorId == userId) {
            myReposnes.add(ent);
            available.remove(ent);
          }
        }
      }
    }

    emit(state.copyWith(
        usersProjects: myProjects,
        status: Status.initial,
        available: available,
        userResponses: myReposnes));
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
    ProjectEntity incoming = event.entity;
    LiteUserEntity author;

    if (incoming.authorId != authorized.dirId.toString()) {
      final rawAuthor = await directus.readOne(
        collection: DirectusCollections.usersCollection,
        id: incoming.authorId,
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
        collection: DirectusCollections.projectsCollection, id: incoming.dirId);
    List<int> rawIds = List.from(rawPrj['proposals']).cast<int>();

    if (rawIds.length != incoming.proposals?.length) {
      Set<int> rawSet = rawIds.toSet();
      List<int> fresh = [];
      List<ProposalEntity> props = [];

      if (incoming.proposals?.isNotEmpty ?? false) {
        for (ProposalEntity prop in incoming.proposals!) {
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
      incoming = incoming.copyWith(proposals: props);
    }

    navigationService.config.push(
      AppRoutes.projectPage.path,
      extra: ProjectPageData(
        entity: incoming,
        author: author,
        isMe: event.entity.authorId == authorized.dirId.toString(),
      ),
    );

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
      projectId: int.parse(event.entity.dirId),
    );
    final raw = await directus.createOne(
      collection: DirectusCollections.proposalsCollections,
      data: proposalEntity.toMap(),
    );
    List<ProjectEntity> all = List.from(state.available);
    List<ProjectEntity> my = List.from(state.userResponses);
    all.remove(event.entity);
    my.add(event.entity);
    emit(state.copyWith(available: all, userResponses: my));
    navigationService.config.pop();
    log(raw.toString());
  }

  FutureOr<void> _editProject(
      EditProjectEvent event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final ProjectDataModel model = event.projectEntity.toModel();

    await directus.updateOne(
        collection: DirectusCollections.projectsCollection,
        itemId: event.projectEntity.dirId,
        updateData: model.toMap());
    List<ProjectEntity> userPrs = List.from(state.usersProjects);
    ProjectEntity torplc =
        userPrs.firstWhere((prj) => prj.dirId == event.projectEntity.dirId);
    userPrs.remove(torplc);
    userPrs.add(event.projectEntity);

    emit(state.copyWith(status: Status.success, usersProjects: userPrs));
    navigationService.config.go(AppRoutes.projects.path);
    log('User projects: ${userPrs.length}');
  }

  FutureOr<void> _deleteProject(
      DeleteProject event, Emitter<ProjectState> emit) async {
    List<ProjectEntity> userprs = List.from(state.usersProjects);
    userprs.remove(event.projectEntity);
    emit(state.copyWith(usersProjects: userprs));
    navigationService.config.go(AppRoutes.projects.path);
    await directus.deleteOne(
        collection: DirectusCollections.projectsCollection,
        id: event.projectEntity.dirId);
  }
}
