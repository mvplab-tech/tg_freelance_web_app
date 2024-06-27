import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:darttonconnect/models/wallet_app.dart';
import 'package:darttonconnect/parsers/connect_event.dart';
import 'package:darttonconnect/ton_connect.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tg_freelance/core/di/injectable.dart';
import 'package:tg_freelance/core/router/navigation_service.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';

part 'ton_event.dart';
// part 'ton_state.dart';

final tonBloc = getIt<TonBloc>();

@Singleton()
class TonBloc extends Bloc<TonEvent, TonState> {
  TonBloc()
      : super(const TonMainState(
            status: Status.initial,
            availableWallets: [],
            connector: null,
            account: null)) {
    on<TonInit>(_init);
    on<TonConnectWallet>(_connect);
    on<TonOnConnect>(_onConnect);
    on<TonFailedConnect>(_failedConnect);
    on<TonDisconnect>(_disconnect);
  }

  FutureOr<void> _init(TonInit event, Emitter<TonState> emit) async {
    final connector = TonConnect(
        'https://raw.githubusercontent.com/mvplab-tech/tg_freelance_web_app/main/tonconnect-manifest.json');

    if (!connector.connected) {
      await connector.restoreConnection();
    }
    final List<WalletApp> wallets = await connector.getWallets();
    // wallets.add(const WalletApp(
    //   name: 'Telegram Wallet',
    //   bridgeUrl: "https://bridge.tonapi.io/bridge",
    //   image: "https://wallet.tg/images/logo-288.png",
    //   aboutUrl: "https://wallet.tg/",
    //   universalUrl: "https://t.me/wallet?attach=wallet",
    // ));
    emit(state.copyWith(availableWallets: wallets, connector: connector));
    // print(connector.wallet?.device!.appName);
    if (connector.account != null) {
      Account account = connector.account as Account;
      emit(state.copyWith(account: account));
    }

    // connector.disconnect();

    connector.onStatusChange((value) async {
      add(TonOnConnect(value: value));
    });
  }

  FutureOr<void> _connect(
      TonConnectWallet event, Emitter<TonState> emit) async {
    emit(state.copyWith(status: Status.initial));
    state.connector!.provider!.listen((e) {
      log(e.toString(), name: 'Provider listener');
      if (e.toString().contains('error')) {
        add(TonFailedConnect());
        // emit(state.copyWith(status: Status.initial));
      }
    });

    emit(state.copyWith(status: Status.loading));
  }

  FutureOr<void> _onConnect(TonOnConnect event, Emitter<TonState> emit) {
    log(event.value.toString());
    log(event.value.runtimeType.toString());

    if (event.value.runtimeType == WalletInfo && event.value != null) {
      WalletInfo info = event.value as WalletInfo;
      Account account = info.account!;
      emit(state.copyWith(account: account, status: Status.success));
      navigationService.config.pop();
      emit(state.copyWith(status: Status.initial));
      // userbloc.add(UserCreateNewUser(name: name))
    } else {
      emit(state.copyWith(status: Status.error));
    }

    log('Status: ${state.status}, account: ${state.account}');
  }

  FutureOr<void> _failedConnect(
      TonFailedConnect event, Emitter<TonState> emit) {
    emit(state.copyWith(status: Status.initial));
  }

  FutureOr<void> _disconnect(TonDisconnect event, Emitter<TonState> emit) {
    if (state.connector != null && state.connector!.connected) {
      state.connector!.disconnect();
      emit(state.copyWith(account: null));
    }
  }
}
