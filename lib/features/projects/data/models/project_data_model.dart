// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProjectDataModel {
  final Map<String, dynamic> liteAuthor;

  final String projectName; //TODO: length 200
  final int date;
  final Map<String, dynamic> budget;
  final String projectType;
  final String description;
  final String expertiseLevel;
  final List<String> filePaths;
  final List<Map<String, dynamic>> proposals;

  ProjectDataModel({
    required this.liteAuthor,
    required this.projectName,
    required this.date,
    required this.budget,
    required this.projectType,
    required this.description,
    required this.expertiseLevel,
    required this.filePaths,
    required this.proposals,
  });

  ProjectDataModel copyWith({
    Map<String, dynamic>? liteAuthor,
    String? projectName,
    int? date,
    Map<String, dynamic>? budget,
    String? projectType,
    String? description,
    String? expertiseLevel,
    List<String>? filePaths,
    List<Map<String, dynamic>>? proposals,
  }) {
    return ProjectDataModel(
      liteAuthor: liteAuthor ?? this.liteAuthor,
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
      'liteAuthor': liteAuthor,
      'projectName': projectName,
      'date': date,
      'budget': budget,
      'projectType': projectType,
      'description': description,
      'expertiseLevel': expertiseLevel,
      'filePaths': filePaths,
      'proposals': proposals,
    };
  }

  factory ProjectDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectDataModel(
      liteAuthor: Map<String, dynamic>.from(
          (map['liteAuthor'] as Map<String, dynamic>)),
      projectName: map['projectName'] as String,
      date: map['date'] as int,
      budget:
          Map<String, dynamic>.from((map['budget'] as Map<String, dynamic>)),
      projectType: map['projectType'] as String,
      description: map['description'] as String,
      expertiseLevel: map['expertiseLevel'] as String,
      filePaths: List<String>.from((map['filePaths'] as List<String>)),
      proposals: List<Map<String, dynamic>>.from(
        (map['proposals']).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDataModel.fromJson(String source) =>
      ProjectDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectDataModel(liteAuthor: $liteAuthor, projectName: $projectName, date: $date, budget: $budget, projectType: $projectType, description: $description, expertiseLevel: $expertiseLevel, filePaths: $filePaths, proposals: $proposals)';
  }

  @override
  bool operator ==(covariant ProjectDataModel other) {
    if (identical(this, other)) return true;

    return mapEquals(other.liteAuthor, liteAuthor) &&
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
    return liteAuthor.hashCode ^
        projectName.hashCode ^
        date.hashCode ^
        budget.hashCode ^
        projectType.hashCode ^
        description.hashCode ^
        expertiseLevel.hashCode ^
        filePaths.hashCode ^
        proposals.hashCode;
  }
}
