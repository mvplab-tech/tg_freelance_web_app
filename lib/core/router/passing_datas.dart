// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tg_freelance/features/projects/domain/entities/project_entity.dart';
import 'package:tg_freelance/features/user/domain/lite_user_entity.dart';

class ProjectPageData {
  final ProjectEntity entity;
  final LiteUserEntity author;
  final bool isMe;
  const ProjectPageData({
    required this.entity,
    required this.author,
    required this.isMe,
  });
}
