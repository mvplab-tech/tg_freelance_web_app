// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserEntity {
  int dirId;
  int tgId;
  String userName;
  String occupation;
  String skills;
  String portfolioUrl;
  UserEntity({
    required this.dirId,
    required this.tgId,
    required this.userName,
    required this.occupation,
    required this.skills,
    required this.portfolioUrl,
  });

  UserEntity copyWith({
    int? dirId,
    int? tgId,
    String? userName,
    String? occupation,
    String? skills,
    String? portfolioUrl,
  }) {
    return UserEntity(
      dirId: dirId ?? this.dirId,
      tgId: tgId ?? this.tgId,
      userName: userName ?? this.userName,
      occupation: occupation ?? this.occupation,
      skills: skills ?? this.skills,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dirId': dirId,
      'tgId': tgId,
      'userName': userName,
      'occupation': occupation,
      'skills': skills,
      'portfolioUrl': portfolioUrl,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      dirId: map['id'] as int,
      tgId: map['tgId'] as int,
      userName: map['userName'] as String,
      occupation: map['description']['occupation'] as String? ?? '',
      skills: map['description']['skills'] as String? ?? '',
      portfolioUrl: map['description']['portfolioUrl'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity(dirId: $dirId, tgId: $tgId, userName: $userName, occupation: $occupation, skills: $skills, portfolioUrl: $portfolioUrl)';
  }

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.dirId == dirId &&
        other.tgId == tgId &&
        other.userName == userName &&
        other.occupation == occupation &&
        other.skills == skills &&
        other.portfolioUrl == portfolioUrl;
  }

  @override
  int get hashCode {
    return dirId.hashCode ^
        tgId.hashCode ^
        userName.hashCode ^
        occupation.hashCode ^
        skills.hashCode ^
        portfolioUrl.hashCode;
  }
}
