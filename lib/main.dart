import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:tg_freelance/app.dart';
import 'package:tg_freelance/core/constants/tg_consts.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/services/directus/directus_service_impl.dart';
import 'package:tg_freelance/features/projects/presentation/bloc/project_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await directus.initDirectus();
  tg.expand();
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(create: (context) => getIt<ProjectBloc>()),
        BlocProvider(create: (context) => getIt<TonBloc>()),
      ],
      child: Pulse(
        theme: TelegramThemeUtil.getTheme(
          TelegramWebApp.instance.isSupported
              ? TelegramWebApp.instance
              : TelegramWebAppFake(),
        )!,
      ),
    );
  }
}
