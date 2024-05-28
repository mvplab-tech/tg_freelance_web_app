import 'dart:convert';

class ProposalEntity {
  final int dirId;
  final String userName;
  final String userPicUrl;
  final String coverLetter;
  final DateTime date;

  ProposalEntity({
    required this.dirId,
    required this.userName,
    required this.userPicUrl,
    required this.coverLetter,
    required this.date,
  });

  ProposalEntity copyWith({
    int? dirId,
    String? userName,
    String? userPicUrl,
    String? coverLetter,
    DateTime? date,
  }) {
    return ProposalEntity(
      dirId: dirId ?? this.dirId,
      userName: userName ?? this.userName,
      userPicUrl: userPicUrl ?? this.userPicUrl,
      coverLetter: coverLetter ?? this.coverLetter,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dirId': dirId,
      'userName': userName,
      'userPicUrl': userPicUrl,
      'coverLetter': coverLetter,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory ProposalEntity.fromMap(Map<String, dynamic> map) {
    return ProposalEntity(
      dirId: map['dirId'] as int,
      userName: map['userName'] as String,
      userPicUrl: map['userPicUrl'] as String,
      coverLetter: map['coverLetter'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProposalEntity.fromJson(String source) =>
      ProposalEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProposalEntity(dirId: $dirId, userName: $userName, userPicUrl: $userPicUrl, coverLetter: $coverLetter, date: $date)';
  }

  @override
  bool operator ==(covariant ProposalEntity other) {
    if (identical(this, other)) return true;

    return other.dirId == dirId &&
        other.userName == userName &&
        other.userPicUrl == userPicUrl &&
        other.coverLetter == coverLetter &&
        other.date == date;
  }

  @override
  int get hashCode {
    return dirId.hashCode ^
        userName.hashCode ^
        userPicUrl.hashCode ^
        coverLetter.hashCode ^
        date.hashCode;
  }
}
