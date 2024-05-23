// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tg_freelance/core/router/navigation_service.dart' as _i5;
import 'package:tg_freelance/core/router/navigator_key_provider.dart' as _i4;
import 'package:tg_freelance/core/services/directus/directus_service.dart'
    as _i6;
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart'
    as _i7;
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart'
    as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.UserBloc>(() => _i3.UserBloc());
    gh.lazySingleton<_i4.NavigatorKeyProvider>(
        () => _i4.NavigatorKeyProvider());
    gh.lazySingleton<_i5.NavigationService>(
        () => _i5.NavigationService(gh<_i4.NavigatorKeyProvider>()));
    gh.singleton<_i6.DirectusService>(() => _i7.DirectusServiceImpl());
    return this;
  }
}
