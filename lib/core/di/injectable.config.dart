// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tg_freelance/core/router/navigation_service.dart' as _i7;
import 'package:tg_freelance/core/router/navigator_key_provider.dart' as _i6;
import 'package:tg_freelance/core/services/directus/directus_service.dart'
    as _i8;
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart'
    as _i9;
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart'
    as _i3;
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart'
    as _i5;
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart'
    as _i4;

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
    gh.singleton<_i3.ProjectBloc>(() => _i3.ProjectBloc());
    gh.singleton<_i4.UserBloc>(() => _i4.UserBloc());
    gh.singleton<_i5.TonBloc>(() => _i5.TonBloc());
    gh.lazySingleton<_i6.NavigatorKeyProvider>(
        () => _i6.NavigatorKeyProvider());
    gh.lazySingleton<_i7.NavigationService>(
        () => _i7.NavigationService(gh<_i6.NavigatorKeyProvider>()));
    gh.singleton<_i8.DirectusService>(() => _i9.DirectusServiceImpl());
    return this;
  }
}
