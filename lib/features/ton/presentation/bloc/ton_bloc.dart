import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darttonconnect/models/wallet_app.dart';
import 'package:darttonconnect/ton_connect.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';

part 'ton_event.dart';
// part 'ton_state.dart';

final tonBloc = getIt<TonBloc>();

@Singleton()
class TonBloc extends Bloc<TonEvent, TonState> {
  TonBloc() : super(const TonMainState(status: Status.initial)) {
    on<TonInit>(_init);
  }

  FutureOr<void> _init(TonInit event, Emitter<TonState> emit) async {
    final connector = TonConnect(
        'https://raw.githubusercontent.com/XaBbl4/pytonconnect/main/pytonconnect-manifest.json');
    final List<WalletApp> wallets = await connector.getWallets();
    // print('Wallets: ${wallets.toString()}');
  }
}
