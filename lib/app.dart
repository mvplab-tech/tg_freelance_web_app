// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tg_freelance/core/constants/styles/text_styles.dart';
import 'package:tg_freelance/core/constants/styles/theme.dart';
import 'package:tg_freelance/core/router/navigation_service.dart';

final _routerConfig = navigationService.config;

class Pulse extends StatelessWidget {
  const Pulse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pulse',
      theme: PulseTheme.lightTheme.copyWith(extensions: <ThemeExtension>[
        AppTextStyles(
          title1: appTextStyles.title1,
          title2: appTextStyles.title2,
          title3: appTextStyles.title3,
          headline: appTextStyles.headline,
          body: appTextStyles.body,
          callout: appTextStyles.callout,
          subheadline1: appTextStyles.subheadline1,
          subheadline2: appTextStyles.subheadline2,
          footnote: appTextStyles.footnote,
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
