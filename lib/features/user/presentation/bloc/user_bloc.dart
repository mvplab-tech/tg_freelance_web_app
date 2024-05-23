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
    occupation: '',
    skills: '',
    portfolioUrl: '');

@Singleton()
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(
          UserMainState(authorizedUser: unauthorized, status: Status.initial),
        ) {
    on<UserInitEvent>(_userInit);
    on<UserCreateNewUser>(_createNewUser);
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

      // final freshUser = await directus.createOne(
      //   collection: DirectusCollections.usersCollection,
      //   data: {
      //     'tgId': tgUser.id,
      //     'userName': userName,
      //     'description': {},
      //   },
      // );
      emit(
        state.copyWith(
          authorizedUser: UserEntity(
            dirId: 0,
            tgId: tgUser.id,
            userName: userName,
            occupation: '',
            skills: 'skills',
            portfolioUrl: 'portfolioUrl',
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
        'description': {},
      },
    );
    emit(
      state.copyWith(
        authorizedUser: UserEntity(
            dirId: freshUser['id'],
            tgId: state.authorizedUser.tgId,
            userName: event.name,
            occupation: '',
            skills: '',
            portfolioUrl: ''),
      ),
    );
  }
}
