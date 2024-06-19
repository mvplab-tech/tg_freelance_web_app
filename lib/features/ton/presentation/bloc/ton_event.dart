// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ton_bloc.dart';

@immutable
sealed class TonEvent {}

class TonInit extends TonEvent {}

class TonConnectWallet extends TonEvent {
  final WalletApp app;
  TonConnectWallet({
    required this.app,
  });
}

class TonOnConnect extends TonEvent {
  final dynamic value;
  TonOnConnect({
    required this.value,
  });
}

class TonFailedConnect extends TonEvent {}

class TonDisconnect extends TonEvent {}
