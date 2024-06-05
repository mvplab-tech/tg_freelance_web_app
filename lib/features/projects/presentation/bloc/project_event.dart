// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'project_bloc.dart';

@immutable
sealed class ProjectEvent {}

class ProjectCreateNew extends ProjectEvent {
  final ProjectEntity project;
  ProjectCreateNew({
    required this.project,
  });
}

class ProjectFetchProjects extends ProjectEvent {
  ProjectFetchProjects();
}

class ProjectOpenProject extends ProjectEvent {
  final ProjectEntity entity;
  ProjectOpenProject({
    required this.entity,
  });
}

class ProjectSubmitProposal extends ProjectEvent {
  final String coverLetter;
  final ProjectEntity entity;
  ProjectSubmitProposal({
    required this.coverLetter,
    required this.entity,
  });
}

class EditProjectEvent extends ProjectEvent {
  final ProjectEntity projectEntity;
  EditProjectEvent({
    required this.projectEntity,
  });
}

class DeleteProject extends ProjectEvent {
  final ProjectEntity projectEntity;
  DeleteProject({
    required this.projectEntity,
  });
}

// class ProjectsFetchUserResponds extends ProjectEvent {
//   final List<int> propsIds;
//   ProjectsFetchUserResponds({
//     required this.propsIds,
//   });
// }
