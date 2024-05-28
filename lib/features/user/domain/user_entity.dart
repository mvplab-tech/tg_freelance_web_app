import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';

class UserEntity {
  final int dirId;
  final int tgId;
  final String userName;
  final FreelancerProfile? freelancerProfile;
  final ClientProfile? clientProfile;

  UserEntity({
    required this.dirId,
    required this.tgId,
    required this.userName,
    this.freelancerProfile,
    this.clientProfile,
  });

  UserEntity copyWith({
    int? dirId,
    int? tgId,
    String? userName,
    FreelancerProfile? freelancerProfile,
    ClientProfile? clientProfile,
  }) {
    return UserEntity(
      dirId: dirId ?? this.dirId,
      tgId: tgId ?? this.tgId,
      userName: userName ?? this.userName,
      freelancerProfile: freelancerProfile ?? this.freelancerProfile,
      clientProfile: clientProfile ?? this.clientProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dirId': dirId,
      'tgId': tgId,
      'userName': userName,
      'freelancerProfile': freelancerProfile?.toMap(),
      'clientProfile': clientProfile?.toMap(),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      dirId: map['id'] as int,
      tgId: map['tgId'] as int,
      userName: map['userName'] as String,
      freelancerProfile:
          map['occupation'] != null && map['expertiseLevel'] != null
              ? FreelancerProfile.fromMap(map)
              : null,
      clientProfile: ClientProfile.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity(dirId: $dirId, tgId: $tgId, userName: $userName, freelancerProfile: $freelancerProfile, clientProfile: $clientProfile)';
  }

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.dirId == dirId &&
        other.tgId == tgId &&
        other.userName == userName &&
        other.freelancerProfile == freelancerProfile &&
        other.clientProfile == clientProfile;
  }

  @override
  int get hashCode {
    return dirId.hashCode ^
        tgId.hashCode ^
        userName.hashCode ^
        freelancerProfile.hashCode ^
        clientProfile.hashCode;
  }
}

class FreelancerProfile {
  final String aboutMeFreelancer;
  final ProjectType occupation;
  final ExpertiseLevel expertiseLevel;
  final List<String> skills;

  FreelancerProfile({
    required this.aboutMeFreelancer,
    required this.occupation,
    required this.expertiseLevel,
    required this.skills,
  });

  FreelancerProfile copyWith({
    String? aboutMeFreelancer,
    ProjectType? occupation,
    ExpertiseLevel? expertiseLevel,
    List<String>? skills,
  }) {
    return FreelancerProfile(
      aboutMeFreelancer: aboutMeFreelancer ?? this.aboutMeFreelancer,
      occupation: occupation ?? this.occupation,
      expertiseLevel: expertiseLevel ?? this.expertiseLevel,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aboutMeFreelancer': aboutMeFreelancer,
      'occupation': occupation.name,
      'expertiseLevel': expertiseLevel.name,
      'skills': skills,
    };
  }

  factory FreelancerProfile.fromMap(Map<String, dynamic> map) {
    return FreelancerProfile(
      aboutMeFreelancer: map['aboutMeFreelancer'] ?? '',
      occupation: ProjectType.values.byName(map['occupation']),
      expertiseLevel: ExpertiseLevel.values.byName(map['expertiseLevel']),
      skills: List<String>.from((map['skills'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory FreelancerProfile.fromJson(String source) =>
      FreelancerProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FreelancerProfile(aboutMe: $aboutMeFreelancer, occupation: $occupation, expertiseLevel: $expertiseLevel, skills: $skills)';
  }

  @override
  bool operator ==(covariant FreelancerProfile other) {
    if (identical(this, other)) return true;

    return other.aboutMeFreelancer == aboutMeFreelancer &&
        other.occupation == occupation &&
        other.expertiseLevel == expertiseLevel &&
        listEquals(other.skills, skills);
  }

  @override
  int get hashCode {
    return aboutMeFreelancer.hashCode ^
        occupation.hashCode ^
        expertiseLevel.hashCode ^
        skills.hashCode;
  }
}

class ClientProfile {
  final String aboutMeClient;
  ClientProfile({
    required this.aboutMeClient,
  });

  ClientProfile copyWith({
    String? aboutMeClient,
  }) {
    return ClientProfile(
      aboutMeClient: aboutMeClient ?? this.aboutMeClient,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aboutMeClient': aboutMeClient,
    };
  }

  factory ClientProfile.fromMap(Map<String, dynamic> map) {
    return ClientProfile(
      aboutMeClient: map['aboutMeClient'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProfile.fromJson(String source) =>
      ClientProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClientProfile(aboutMeClient: $aboutMeClient)';

  @override
  bool operator ==(covariant ClientProfile other) {
    if (identical(this, other)) return true;

    return other.aboutMeClient == aboutMeClient;
  }

  @override
  int get hashCode => aboutMeClient.hashCode;
}
