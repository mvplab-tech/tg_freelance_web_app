// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';

class ProjectDataModel {
  final String authorId;
  final String dirId;
  final String projectName; //TODO: length 200
  final int date;
  final Map<String, dynamic> budget;
  final String projectType;
  final String description;
  final String expertiseLevel;
  final List<String> filePaths;
  final List<String> skills;
  final List<Map<String, dynamic>> proposals;

  ProjectDataModel({
    required this.authorId,
    required this.dirId,
    required this.projectName,
    required this.date,
    required this.budget,
    required this.projectType,
    required this.description,
    required this.expertiseLevel,
    required this.filePaths,
    required this.proposals,
    required this.skills,
  });

  ProjectDataModel copyWith({
    String? authorId,
    String? dirId,
    String? projectName,
    int? date,
    Map<String, dynamic>? budget,
    String? projectType,
    String? description,
    String? expertiseLevel,
    List<String>? filePaths,
    List<String>? skills,
    List<Map<String, dynamic>>? proposals,
  }) {
    return ProjectDataModel(
      authorId: authorId ?? this.authorId,
      dirId: dirId ?? this.dirId,
      skills: skills ?? this.skills,
      projectName: projectName ?? this.projectName,
      date: date ?? this.date,
      budget: budget ?? this.budget,
      projectType: projectType ?? this.projectType,
      description: description ?? this.description,
      expertiseLevel: expertiseLevel ?? this.expertiseLevel,
      filePaths: filePaths ?? this.filePaths,
      proposals: proposals ?? this.proposals,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorId': authorId,
      'projectName': projectName,
      'timeStamp': date,
      'projectBudget': budget,
      'skills': skills,
      'projectType': projectType,
      'description': description,
      'expertiseLevel': expertiseLevel,
      'filePaths': filePaths,
      'proposals': proposals,
    };
  }

  factory ProjectDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectDataModel(
      authorId: map['authorId'].toString(),
      dirId: map['id'].toString(),
      projectName: map['projectName'] as String,
      date: int.parse(map['timeStamp']),
      skills: List<String>.from((map['skills'])),
      budget: Map<String, dynamic>.from((map['projectBudget'])),
      projectType: map['projectType'] as String,
      description: map['description'] as String,
      expertiseLevel: map['expertiseLevel'] as String,
      filePaths: List<String>.from((map['filePaths'] ?? [])),
      proposals: List<Map<String, dynamic>>.from((map['proposals'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDataModel.fromJson(String source) =>
      ProjectDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectDataModel(authorId: $authorId, projectName: $projectName, date: $date, budget: $budget, projectType: $projectType, description: $description, expertiseLevel: $expertiseLevel, filePaths: $filePaths, proposals: $proposals)';
  }

  @override
  bool operator ==(covariant ProjectDataModel other) {
    if (identical(this, other)) return true;

    return other.authorId == authorId &&
        other.projectName == projectName &&
        other.date == date &&
        mapEquals(other.budget, budget) &&
        other.projectType == projectType &&
        other.description == description &&
        other.expertiseLevel == expertiseLevel &&
        listEquals(other.filePaths, filePaths) &&
        listEquals(other.proposals, proposals);
  }

  @override
  int get hashCode {
    return authorId.hashCode ^
        projectName.hashCode ^
        date.hashCode ^
        budget.hashCode ^
        projectType.hashCode ^
        description.hashCode ^
        expertiseLevel.hashCode ^
        filePaths.hashCode ^
        proposals.hashCode;
  }

  ProjectEntity toEntity() {
    return ProjectEntity(
        authorId: authorId,
        projectName: projectName,
        date: DateTime.fromMillisecondsSinceEpoch(date),
        budget: BudgetClass.fromMap(budget),
        projectType: ProjectType.values.byName(projectType),
        description: description,
        expertiseLevel: ExpertiseLevel.values.byName(expertiseLevel),
        dirId: dirId,
        skills: skills,
        filePaths: filePaths,
        proposals: proposals.map((el) {
          return ProposalEntity.fromMap(el);
        }).toList());
  }
}
