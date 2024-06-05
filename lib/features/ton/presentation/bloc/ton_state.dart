import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tg_freelance/core/status.dart';

part 'ton_state.freezed.dart';

@freezed
sealed class TonState with _$TonState {
  const factory TonState.mainState({
    required Status status,
    // required UserEntity authorizedUser,
    // final UserEntity? elseUser,
  }) = TonMainState;
}

extension TonStateX on TonState {
  // bool get isAuthorized => authorizedUser.tgId != 0;
  // bool get isFreelancerFilled => authorizedUser.freelancerProfile != null;
  // bool get isClientFilled =>
  //     authorizedUser.clientProfile != null &&
  //     authorizedUser.clientProfile!.aboutMeClient.isNotEmpty;
}
