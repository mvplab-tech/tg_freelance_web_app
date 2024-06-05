import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:tg_freelance/core/constants/tg_consts.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    userbloc.add(
      UserInitEvent(
        webAppData: tg.isSupported ? tg : TelegramWebAppFake(),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tonBloc.add(TonInit());
      if (!tonBloc.state.connector!.connected) {
        tonBloc.state.connector!.restoreConnection();
      }
    });
    return Scaffold(
      body: Center(
        child: Text(
          'Pulse',
          style: context.styles.header1,
        ),
      ),
    );
  }
}
