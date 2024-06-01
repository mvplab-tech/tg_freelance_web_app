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
  final int projectId;
  ProjectSubmitProposal({
    required this.coverLetter,
    required this.projectId,
  });
}
