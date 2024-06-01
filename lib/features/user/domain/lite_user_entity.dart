// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LiteUserEntity {
  final int dirId;
  final String userName;
  final String userPicUrl;
  final int amountOfProjects;
  LiteUserEntity({
    required this.dirId,
    required this.userName,
    required this.userPicUrl,
    required this.amountOfProjects,
  });

  LiteUserEntity copyWith({
    int? dirId,
    String? userName,
    String? userPicUrl,
    int? amountOfProjects,
  }) {
    return LiteUserEntity(
      dirId: dirId ?? this.dirId,
      userName: userName ?? this.userName,
      userPicUrl: userPicUrl ?? this.userPicUrl,
      amountOfProjects: amountOfProjects ?? this.amountOfProjects,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dirId': dirId,
      'userName': userName,
      'userPicUrl': userPicUrl,
      'amountOfProjects': amountOfProjects,
    };
  }

  factory LiteUserEntity.fromMap(Map<String, dynamic> map) {
    return LiteUserEntity(
      dirId: map['id'] as int,
      userName: map['userName'] as String,
      userPicUrl: map['userPicUrl'] ?? '',
      amountOfProjects: List.from(map['projectIds']).length,
    );
  }

  String toJson() => json.encode(toMap());

  factory LiteUserEntity.fromJson(String source) =>
      LiteUserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LiteUserEntity(dirId: $dirId, userName: $userName, userPicUrl: $userPicUrl, amountOfProjects: $amountOfProjects)';
  }

  @override
  bool operator ==(covariant LiteUserEntity other) {
    if (identical(this, other)) return true;

    return other.dirId == dirId &&
        other.userName == userName &&
        other.userPicUrl == userPicUrl &&
        other.amountOfProjects == amountOfProjects;
  }

  @override
  int get hashCode {
    return dirId.hashCode ^
        userName.hashCode ^
        userPicUrl.hashCode ^
        amountOfProjects.hashCode;
  }
}
