import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/router/navigator_key_provider.dart';
import 'package:tg_freelance/features/projects/presentation/pages/projects_page.dart';
import 'package:tg_freelance/features/splash_screen.dart';
import 'package:tg_freelance/features/user/presentation/pages/create_account_page.dart';

final navigationService = getIt<NavigationService>();

@LazySingleton()
class NavigationService {
  late final GoRouter _router;
  final NavigatorKeyProvider navigatorKeyProvider;

  NavigationService(this.navigatorKeyProvider)
      : _router = _buildRouter(navigatorKeyProvider.rootNavigatorKey,
            navigatorKeyProvider.rootNavigatorKey);

  GoRouter get config => _router;
  static BuildContext? get ctx =>
      navigationService.config.routerDelegate.navigatorKey.currentContext;

  static GoRouter _buildRouter(GlobalKey<NavigatorState> navigatorKey,
      GlobalKey<NavigatorState> rootNavigatorKey) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: AppRoutes.splash.path,
      debugLogDiagnostics: false,
      routes: [
        GoRoute(
          name: AppRoutes.createAccount.name,
          path: AppRoutes.createAccount.path,
          builder: (_, __) => const CreateAccountPage(),
        ),
        GoRoute(
          name: AppRoutes.projects.name,
          path: AppRoutes.projects.path,
          builder: (_, __) => const ProjectsPage(),
        ),
        GoRoute(
          name: AppRoutes.splash.name,
          path: AppRoutes.splash.path,
          builder: (_, __) => const SplashScreen(),
        ),
      ],
    );
  }
}