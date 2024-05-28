// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserInitEvent extends UserEvent {
  final TelegramWebApp webAppData;
  UserInitEvent({required this.webAppData});
}

class UserCreateNewUser extends UserEvent {
  final String name;
  UserCreateNewUser({
    required this.name,
  });
}

class UserUpdateData extends UserEvent {
  final FreelancerProfile freelancer;
  final ClientProfile client;
  final String? updName;
  UserUpdateData({
    required this.freelancer,
    required this.client,
    this.updName,
  });
}
