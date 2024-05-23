import 'dart:convert';

class TgUserEntity {
  int tgId;
  String name;
  String lastName;
  String nickName;
  DateTime authDate;
  TgUserEntity({
    required this.tgId,
    required this.name,
    required this.lastName,
    required this.nickName,
    required this.authDate,
  });

  TgUserEntity copyWith({
    int? tgId,
    String? name,
    String? lastName,
    String? nickName,
    DateTime? authDate,
  }) {
    return TgUserEntity(
      tgId: tgId ?? this.tgId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      nickName: nickName ?? this.nickName,
      authDate: authDate ?? this.authDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tgId': tgId,
      'name': name,
      'lastName': lastName,
      'nickName': nickName,
      'authDate': authDate.millisecondsSinceEpoch,
    };
  }

  factory TgUserEntity.fromMap(Map<String, dynamic> map) {
    return TgUserEntity(
      tgId: map['tgId'] as int,
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      nickName: map['nickName'] as String,
      authDate: DateTime.fromMillisecondsSinceEpoch(map['authDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TgUserEntity.fromJson(String source) =>
      TgUserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TgUserEntity(tgId: $tgId, name: $name, lastName: $lastName, nickName: $nickName, authDate: $authDate)';
  }

  @override
  bool operator ==(covariant TgUserEntity other) {
    if (identical(this, other)) return true;

    return other.tgId == tgId &&
        other.name == name &&
        other.lastName == lastName &&
        other.nickName == nickName &&
        other.authDate == authDate;
  }

  @override
  int get hashCode {
    return tgId.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        nickName.hashCode ^
        authDate.hashCode;
  }

//  factory TgUserEntity.fromTg(TelegramUser user) {
//     return TgUserEntity(
//       tgId: 0,
//       name: '',
//       lastName: 'lastName',
//       nickName: 'nickName',
//       authDate: DateTime.now(),
//     );
//   }
}
