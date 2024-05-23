// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tg_freelance/core/constants/styles/text_styles.dart';
import 'package:tg_freelance/core/router/navigation_service.dart';

final _routerConfig = navigationService.config;

class Pulse extends StatelessWidget {
  final ThemeData theme;
  const Pulse({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pulse',
      theme: theme.copyWith(extensions: <ThemeExtension>[
        AppTextStyles(
          header1: appTextStyles.header1,
          header2: appTextStyles.header2,
          body1: appTextStyles.body1,
          body2: appTextStyles.body2,
          caption1: appTextStyles.caption1,
          caption2: appTextStyles.caption2,
        ),
      ]),
      routeInformationProvider: _routerConfig.routeInformationProvider,
      routerDelegate: _routerConfig.routerDelegate,
      routeInformationParser: _routerConfig.routeInformationParser,
      backButtonDispatcher: _routerConfig.backButtonDispatcher,
    );
  }
}
