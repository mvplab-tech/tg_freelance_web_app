// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProposalEntity {
  final int dirId;
  final int authorId;
  final int projectId;
  final String authorName;
  final String coverLetter;
  final DateTime date;

  ProposalEntity({
    required this.dirId,
    required this.authorId,
    required this.projectId,
    required this.authorName,
    required this.coverLetter,
    required this.date,
  });

  ProposalEntity copyWith({
    int? dirId,
    int? authorId,
    int? projectId,
    String? authorName,
    String? coverLetter,
    DateTime? date,
  }) {
    return ProposalEntity(
      dirId: dirId ?? this.dirId,
      authorId: authorId ?? this.authorId,
      projectId: projectId ?? this.projectId,
      authorName: authorName ?? this.authorName,
      coverLetter: coverLetter ?? this.coverLetter,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dirid': dirId,
      'authorId': authorId,
      'projectId': projectId,
      'authorName': authorName,
      'coverLetter': coverLetter,
      'dateTime': date.millisecondsSinceEpoch,
    };
  }

  factory ProposalEntity.fromMap(Map<String, dynamic> map) {
    return ProposalEntity(
      dirId: map['id'] as int,
      authorId: map['authorId'] as int,
      projectId: map['projectId'] as int,
      authorName: map['authorName'] as String,
      coverLetter: map['coverLetter'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(int.parse(map['dateTime'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProposalEntity.fromJson(String source) =>
      ProposalEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProposalEntity(dirId: $dirId, authorId: $authorId, projectId: $projectId, authorName: $authorName, coverLetter: $coverLetter, date: $date)';
  }

  @override
  bool operator ==(covariant ProposalEntity other) {
    if (identical(this, other)) return true;

    return other.dirId == dirId &&
        other.authorId == authorId &&
        other.projectId == projectId &&
        other.authorName == authorName &&
        other.coverLetter == coverLetter &&
        other.date == date;
  }

  @override
  int get hashCode {
    return dirId.hashCode ^
        authorId.hashCode ^
        projectId.hashCode ^
        authorName.hashCode ^
        coverLetter.hashCode ^
        date.hashCode;
  }
}
