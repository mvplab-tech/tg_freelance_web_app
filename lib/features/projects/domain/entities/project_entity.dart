// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:tg_freelance/features/projects/data/models/project_data_model.dart';
import 'package:tg_freelance/features/projects/domain/entities/proposal_entity.dart';
import 'package:tg_freelance/features/user/domain/lite_user_entity.dart';

class ProjectEntity {
  final LiteUserEntity author;
  final String dirId;
  final String projectName; //TODO: length 200
  final DateTime date;
  final BudgetClass budget;
  final ProjectType projectType;
  final String description;
  final ExpertiseLevel expertiseLevel;
  final List<String> skills;
  final List<String>? filePaths;
  final List<ProposalEntity>? proposals;

  ProjectEntity({
    required this.author,
    required this.projectName,
    required this.date,
    required this.budget,
    required this.projectType,
    required this.description,
    required this.expertiseLevel,
    required this.dirId,
    required this.skills,
    this.filePaths,
    this.proposals,
  });

  ProjectEntity copyWith({
    LiteUserEntity? author,
    String? projectName,
    String? dirId,
    DateTime? date,
    BudgetClass? budget,
    ProjectType? projectType,
    String? description,
    ExpertiseLevel? expertiseLevel,
    List<String>? skills,
    List<String>? filePaths,
    List<ProposalEntity>? proposals,
  }) {
    return ProjectEntity(
      author: author ?? this.author,
      dirId: dirId ?? this.dirId,
      projectName: projectName ?? this.projectName,
      skills: skills ?? this.skills,
      date: date ?? this.date,
      budget: budget ?? this.budget,
      projectType: projectType ?? this.projectType,
      description: description ?? this.description,
      expertiseLevel: expertiseLevel ?? this.expertiseLevel,
      filePaths: filePaths ?? this.filePaths,
      proposals: proposals ?? this.proposals,
    );
  }

  ProjectDataModel toModel() {
    return ProjectDataModel(
      author: author.toMap(),
      dirId: dirId,
      projectName: projectName,
      date: date.millisecondsSinceEpoch,
      budget: {
        'amount': budget.amount,
        'currency': budget.currency,
      },
      projectType: projectType.name,
      description: description,
      expertiseLevel: expertiseLevel.name,
      filePaths: filePaths ?? [],
      proposals: proposals?.map((el) {
            return el.toMap();
          }).toList() ??
          [],
      skills: skills,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'liteAuthor': liteAuthor.toMap(),
  //     'projectName': projectName,
  //     'date': date.millisecondsSinceEpoch,
  //     'budget': budget.toMap(),
  //     'projectType': projectType.toMap(),
  //     'description': description,
  //     'expertiseLevel': expertiseLevel.toMap(),
  //     'filePaths': filePaths,
  //     'proposals': proposals.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory ProjectEntity.fromMap(Map<String, dynamic> map) {
  //   return ProjectEntity(
  //     liteAuthor: LiteUserEntity.fromMap(map['liteAuthor'] as Map<String,dynamic>),
  //     projectName: map['projectName'] as String,
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
  //     budget: BudgetClass.fromMap(map['budget'] as Map<String,dynamic>),
  //     projectType: ProjectType.fromMap(map['projectType'] as Map<String,dynamic>),
  //     description: map['description'] as String,
  //     expertiseLevel: ExpertiseLevel.fromMap(map['expertiseLevel'] as Map<String,dynamic>),
  //     filePaths: List<String>.from((map['filePaths'] as List<String>)),
  //     proposals: List<ProposalEntity>.from((map['proposals'] as List<int>).map<ProposalEntity>((x) => ProposalEntity.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ProjectEntity.fromJson(String source) =>
  //     ProjectEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'ProjectEntity(liteAuthor: $liteAuthor, projectName: $projectName, date: $date, budget: $budget, projectType: $projectType, description: $description, expertiseLevel: $expertiseLevel, filePaths: $filePaths, proposals: $proposals)';
  // }

  // @override
  // bool operator ==(covariant ProjectEntity other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.liteAuthor == liteAuthor &&
  //     other.projectName == projectName &&
  //     other.date == date &&
  //     other.budget == budget &&
  //     other.projectType == projectType &&
  //     other.description == description &&
  //     other.expertiseLevel == expertiseLevel &&
  //     listEquals(other.filePaths, filePaths) &&
  //     listEquals(other.proposals, proposals);
  // }

  // @override
  // int get hashCode {
  //   return liteAuthor.hashCode ^
  //     projectName.hashCode ^
  //     date.hashCode ^
  //     budget.hashCode ^
  //     projectType.hashCode ^
  //     description.hashCode ^
  //     expertiseLevel.hashCode ^
  //     filePaths.hashCode ^
  //     proposals.hashCode;
  // }

  @override
  String toString() {
    return 'ProjectEntity(authorId: $author, projectName: $projectName, date: $date, budget: $budget, projectType: $projectType, description: $description, expertiseLevel: $expertiseLevel, filePaths: $filePaths, proposals: $proposals)';
  }
}

enum ProjectType {
  webDevelopment,
  mobileDevelopment,
  graphicDesign,
  contentWriting,
  digitalMarketing,
  seoOptimization,
  videoEditing,
  dataAnalysis,
  uxUiDesign,
  softwareTesting,
  projectManagement,
  socialMediaManagement,
  translation;
}

// extension Skill on ProjectType{

// }

extension ProjectTypeX on ProjectType {
  String getName() {
    return switch (this) {
      ProjectType.webDevelopment => 'Web Development',
      ProjectType.mobileDevelopment => 'Mobile Development',
      ProjectType.graphicDesign => 'Graphic Design',
      ProjectType.contentWriting => 'Content Writing',
      ProjectType.digitalMarketing => 'Digital Marketing',
      ProjectType.seoOptimization => 'SEO Optimization',
      ProjectType.videoEditing => 'Video Editing',
      ProjectType.dataAnalysis => 'Data Analysis',
      ProjectType.uxUiDesign => 'UX/UI Design',
      ProjectType.softwareTesting => 'Software Testing',
      ProjectType.projectManagement => 'Project Management',
      ProjectType.socialMediaManagement => 'Social Media Management',
      ProjectType.translation => 'Translation',
    };
  }

  String getAsset() {
    const String ic = 'assets/icons/';

    return switch (this) {
      ProjectType.webDevelopment => '${ic}web_dev.svg',
      ProjectType.mobileDevelopment => '${ic}mobile_dev.svg',
      ProjectType.graphicDesign => '${ic}graphic_design.svg',
      ProjectType.contentWriting => '${ic}content_writing.svg',
      ProjectType.digitalMarketing => '${ic}digital_marketing.svg',
      ProjectType.seoOptimization => '${ic}seo.svg',
      ProjectType.videoEditing => '${ic}video_edit.svg',
      ProjectType.dataAnalysis => '${ic}data.svg',
      ProjectType.uxUiDesign => '${ic}ui_ux.svg',
      ProjectType.softwareTesting => '${ic}qa.svg',
      ProjectType.projectManagement => '${ic}project_management.svg',
      ProjectType.socialMediaManagement => '${ic}social_media.svg',
      ProjectType.translation => '${ic}translation.svg',
    };
  }

  String getOccupation() {
    return switch (this) {
      ProjectType.webDevelopment => 'Web Developer',
      ProjectType.mobileDevelopment => 'Mobile Developer',
      ProjectType.graphicDesign => 'Graphic Designer',
      ProjectType.contentWriting => 'Content Writer',
      ProjectType.digitalMarketing => 'Digital Marketer',
      ProjectType.seoOptimization => 'SEO Specialist',
      ProjectType.videoEditing => 'Video Editor',
      ProjectType.dataAnalysis => 'Data Analyst',
      ProjectType.uxUiDesign => 'UX/UI Designer',
      ProjectType.softwareTesting => 'Software Tester',
      ProjectType.projectManagement => 'Project Manager',
      ProjectType.socialMediaManagement => 'Social Media Manager',
      ProjectType.translation => 'Translator',
    };
  }

  List<String> get skills {
    switch (this) {
      case ProjectType.webDevelopment:
        return [
          'HTML/CSS',
          'JavaScript',
          'React.js/Vue.js',
          'Node.js/Django',
          'SQL/NoSQL'
        ];
      case ProjectType.mobileDevelopment:
        return [
          'Flutter/Dart',
          'React Native',
          'Swift/iOS',
          'Kotlin/Android',
          'API Integration'
        ];
      case ProjectType.graphicDesign:
        return [
          'Adobe Photoshop',
          'Adobe Illustrator',
          'Sketch/Figma',
          'Typography',
          'Brand Identity'
        ];
      case ProjectType.contentWriting:
        return [
          'SEO Writing',
          'Copywriting',
          'Technical Writing',
          'Editing/Proofreading',
          'Creative Writing'
        ];
      case ProjectType.digitalMarketing:
        return [
          'SEO',
          'PPC Advertising',
          'Email Marketing',
          'Content Marketing',
          'Analytics'
        ];
      case ProjectType.seoOptimization:
        return [
          'Keyword Research',
          'On-Page SEO',
          'Off-Page SEO',
          'Link Building',
          'Google Analytics'
        ];
      case ProjectType.videoEditing:
        return [
          'Adobe Premiere Pro',
          'Final Cut Pro',
          'After Effects',
          'Motion Graphics',
          'Color Correction'
        ];
      case ProjectType.dataAnalysis:
        return [
          'Python/R',
          'SQL',
          'Data Visualization',
          'Machine Learning',
          'Statistical Analysis'
        ];
      case ProjectType.uxUiDesign:
        return [
          'User Research',
          'Wireframing',
          'Prototyping',
          'User Testing',
          'Interaction Design'
        ];
      case ProjectType.softwareTesting:
        return [
          'Manual Testing',
          'Automated Testing',
          'Selenium/WebDriver',
          'Test Case Development',
          'Bug Tracking'
        ];
      case ProjectType.projectManagement:
        return [
          'Agile/Scrum',
          'Project Planning',
          'Risk Management',
          'Resource Management',
          'Stakeholder Communication'
        ];
      case ProjectType.socialMediaManagement:
        return [
          'Content Creation',
          'Analytics',
          'Engagement Strategies',
          'Social Media Advertising',
          'Community Management'
        ];
      case ProjectType.translation:
        return [
          'Bilingual Proficiency',
          'Cultural Knowledge',
          'CAT Tools',
          'Proofreading',
          'Specialized Terminology'
        ];
      default:
        return [];
    }
  }
}

enum ExpertiseLevel {
  beginner,
  intermediate,
  advanced,
  master;
}

extension ExpertiseLevelX on ExpertiseLevel {
  String getDescription() {
    return switch (this) {
      ExpertiseLevel.beginner => 'Beginner, wondering around',
      ExpertiseLevel.intermediate => 'Intermediate, 1-2 years of experience',
      ExpertiseLevel.advanced => 'Advanced, 2-4 years of experience',
      ExpertiseLevel.master => 'Master, 5+ years of experience'
    };
  }

  String getName() {
    return switch (this) {
      ExpertiseLevel.beginner => 'Beginner',
      ExpertiseLevel.intermediate => 'Intermediate',
      ExpertiseLevel.advanced => 'Advanced',
      ExpertiseLevel.master => 'Master',
    };
  }
}

class BudgetClass {
  final int amount;
  final String currency;
  BudgetClass({
    required this.amount,
    required this.currency,
  });

  BudgetClass copyWith({
    int? amount,
    String? currency,
  }) {
    return BudgetClass(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'currency': currency,
    };
  }

  factory BudgetClass.fromMap(Map<String, dynamic> map) {
    return BudgetClass(
      amount: map['amount'] as int,
      currency: map['currency'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetClass.fromJson(String source) =>
      BudgetClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BudgetClass(amount: $amount, currency: $currency)';

  String uiString() => '$currency $amount';

  @override
  bool operator ==(covariant BudgetClass other) {
    if (identical(this, other)) return true;

    return other.amount == amount && other.currency == currency;
  }

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;
}
