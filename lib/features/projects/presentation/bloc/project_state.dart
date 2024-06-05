import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';

part 'project_state.freezed.dart';

@freezed
sealed class ProjectState with _$ProjectState {
  const factory ProjectState.mainState({
    required Status status,
    required List<ProjectEntity> available,
    required List<ProjectEntity> userResponses,
    required List<ProjectEntity> usersProjects,
    // final UserEntity? elseUser,
  }) = ProjectMainState;
}

extension ProjectStateX on ProjectState {
  List<Widget> get tabs => [
        if (usersProjects.isNotEmpty)
          const Tab(
            text: 'My projects',
          ),
        if (userResponses.isNotEmpty)
          const Tab(
            text: 'My responses',
          )
      ];
}
