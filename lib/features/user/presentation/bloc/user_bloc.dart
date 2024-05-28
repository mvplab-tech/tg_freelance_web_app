import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:directus/directus.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:tg_freelance/core/constants/directus_collections.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/router/navigation_service.dart';
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/user/domain/user_entity.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_state.dart';

part 'user_event.dart';

final userbloc = getIt<UserBloc>();
final unauthorized = UserEntity(
  dirId: 0,
  tgId: 0,
  userName: '',
);

@Singleton()
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(
          UserMainState(authorizedUser: unauthorized, status: Status.initial),
        ) {
    on<UserInitEvent>(_userInit);
    on<UserCreateNewUser>(_createNewUser);
    on<UserUpdateData>(_updateUser);
  }

  FutureOr<void> _userInit(UserInitEvent event, Emitter<UserState> emit) async {
    // log('calls?');
    var tgUser = event.webAppData.initData.user;
    final existingUser = await directus.readMany(
      collection: DirectusCollections.usersCollection,
      filters: Filters(
        {
          'tgId': F.eq(tgUser.id),
        },
      ),
    );
    if (existingUser.isNotEmpty) {
      UserEntity user = UserEntity.fromMap(existingUser.first);
      emit(state.copyWith(authorizedUser: user));
      navigationService.config.pushReplacement(AppRoutes.projects.path);
    } else {
      String userName = '${tgUser.firstname} ${tgUser.lastname}'.trim();
      emit(
        state.copyWith(
          authorizedUser: UserEntity(
            dirId: 0,
            tgId: tgUser.id,
            userName: userName,
          ),
        ),
      );
      navigationService.config.pushReplacement(AppRoutes.createAccount.path);
    }
  }

  FutureOr<void> _createNewUser(
      UserCreateNewUser event, Emitter<UserState> emit) async {
    final freshUser = await directus.createOne(
      collection: DirectusCollections.usersCollection,
      data: {
        'tgId': state.authorizedUser.tgId,
        'userName': event.name,
      },
    );
    emit(
      state.copyWith(
        authorizedUser: UserEntity(
          dirId: freshUser['id'],
          tgId: state.authorizedUser.tgId,
          userName: event.name,
        ),
      ),
    );
    navigationService.config.pushReplacement(AppRoutes.projects.path);
  }

  FutureOr<void> _updateUser(
      UserUpdateData event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));
    UserEntity user = state.authorizedUser;
    UserEntity upd = user.copyWith(
        freelancerProfile: event.freelancer, clientProfile: event.client);
    try {
      final res = await directus.updateOne(
          collection: DirectusCollections.usersCollection,
          itemId: user.dirId.toString(),
          updateData: {
            'userName': event.updName,
            'aboutMeFreelancer': event.freelancer?.aboutMeFreelancer,
            'aboutMeClient': event.client?.aboutMeClient,
            'occupation': event.freelancer?.occupation.name,
            'expertiseLevel': event.freelancer?.expertiseLevel.name,
            'skills': event.freelancer?.skills
          });
      log(res.toString());
    } on DirectusError catch (e) {
      log(e.message.toString());
      log(e.additionalInfo.toString());
    }

    emit(state.copyWith(authorizedUser: upd, status: Status.success));
  }
}
