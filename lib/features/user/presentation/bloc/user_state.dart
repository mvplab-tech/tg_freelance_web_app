import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/user/domain/user_entity.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.mainState({
    required Status status,
    required UserEntity authorizedUser,
    // final UserEntity? elseUser,
  }) = UserMainState;
}

extension UserStateX on UserState {
  bool get isAuthorized => authorizedUser.tgId != 0;
  bool get isFreelancerFilled => authorizedUser.freelancerProfile != null;
  bool get isClientFilled =>
      authorizedUser.clientProfile != null &&
      authorizedUser.clientProfile!.aboutMeClient.isNotEmpty;
}
