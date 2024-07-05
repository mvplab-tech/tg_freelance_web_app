import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/router/app_routes.dart';
import 'package:tg_freelance/core/router/navigator_key_provider.dart';
import 'package:tg_freelance/core/router/passing_datas.dart';
import 'package:tg_freelance/features/projects/presentation/pages/new_project_page.dart';
import 'package:tg_freelance/features/projects/presentation/pages/project_page/project_page.dart';
import 'package:tg_freelance/features/projects/presentation/pages/projects_page.dart';
import 'package:tg_freelance/features/projects/presentation/pages/proposal_page.dart';
import 'package:tg_freelance/features/splash_screen.dart';
import 'package:tg_freelance/features/user/presentation/pages/create_account_page.dart';
import 'package:tg_freelance/features/user/presentation/pages/edit_profile.dart';

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
      overridePlatformDefaultLocation:
          true, //понадобилось потому что при каком-то действии внутри, он начинал считать /projects своей initialLocation
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
        GoRoute(
          name: AppRoutes.profile.name,
          path: AppRoutes.profile.path,
          builder: (_, __) => const EditProfile(),
        ),
        GoRoute(
          name: AppRoutes.createProject.name,
          path: AppRoutes.createProject.path,
          builder: (_, state) => CreateProject(
            editData: state.extra as EditProjectData?,
          ),
        ),
        GoRoute(
          name: AppRoutes.projectPage.name,
          path: AppRoutes.projectPage.path,
          builder: (_, state) => ProjectPage(
            data: state.extra as ProjectPageData,
          ),
        ),
        GoRoute(
          name: AppRoutes.proposalPage.name,
          path: AppRoutes.proposalPage.path,
          builder: (_, state) => ProposalPage(
            data: state.extra as ProposalPageData,
          ),
        ),
      ],
    );
  }
}
