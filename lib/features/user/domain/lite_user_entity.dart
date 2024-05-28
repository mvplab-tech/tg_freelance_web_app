import 'dart:convert';

class LiteUserEntity {
  final int dirId;
  final String userName;
  final String userPicUrl;
  LiteUserEntity({
    required this.dirId,
    required this.userName,
    required this.userPicUrl,
  });

  LiteUserEntity copyWith({
    int? dirId,
    String? userName,
    String? userPicUrl,
  }) {
    return LiteUserEntity(
      dirId: dirId ?? this.dirId,
      userName: userName ?? this.userName,
      userPicUrl: userPicUrl ?? this.userPicUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dirId': dirId,
      'userName': userName,
      'userPicUrl': userPicUrl,
    };
  }

  factory LiteUserEntity.fromMap(Map<String, dynamic> map) {
    return LiteUserEntity(
      dirId: map['dirId'] as int,
      userName: map['userName'] as String,
      userPicUrl: map['userPicUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LiteUserEntity.fromJson(String source) =>
      LiteUserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LiteUserEntity(dirId: $dirId, userName: $userName, userPicUrl: $userPicUrl)';

  @override
  bool operator ==(covariant LiteUserEntity other) {
    if (identical(this, other)) return true;

    return other.dirId == dirId &&
        other.userName == userName &&
        other.userPicUrl == userPicUrl;
  }

  @override
  int get hashCode => dirId.hashCode ^ userName.hashCode ^ userPicUrl.hashCode;
}
