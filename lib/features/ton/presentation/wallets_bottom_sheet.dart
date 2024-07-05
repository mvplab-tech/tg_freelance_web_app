import 'package:darttonconnect/models/wallet_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';

void showWalletsBottomSheet(BuildContext context, String text) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: false,
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          Uri link = Uri();
          return SizedBox(
              width: constraints.maxWidth,
              height: kDebugMode ? 500 : 300,
              child: StatefulBuilder(builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // color: ontext.theme.colorScheme.onTertiary,
                    borderRadius: BorderRadius.circular(20).copyWith(
                      bottomLeft: null,
                      bottomRight: null,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<TonBloc, TonState>(
                      bloc: tonBloc,
                      builder: (context, tonState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              tonState.status == Status.loading
                                  ? 'Connecting...'
                                  : text,
                              style: context.styles.header2,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            if (tonState.account != null &&
                                tonState.status != Status.loading)
                              Center(
                                child: Text(
                                  'CONNECTED',
                                  style: context.styles.header2,
                                ),
                              ),
                            if (tonState.status != Status.loading &&
                                tonState.account == null)
                              _WalletsDisplay(
                                  wallets: tonState.availableWallets,
                                  constraints: constraints,
                                  debugAction: (url) {
                                    state(
                                      () {
                                        link = url;
                                      },
                                    );
                                  }),
                            if (tonState.status == Status.loading) ...[
                              const SizedBox(
                                height: 32,
                              ),
                              Center(
                                  child: kDebugMode
                                      ? Container(
                                          color: Colors.white,
                                          child: QrImageView(
                                            data: link.toString(),
                                            version: QrVersions.auto,
                                            size: 320,
                                            gapless: false,
                                          ),
                                        )
                                      : const CircularProgressIndicator())
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                );
              }));
        },
      );
    },
  ).whenComplete(() {
    if (tonBloc.state.status == Status.loading) {
      tonBloc.add(TonFailedConnect());
    } else {
      // print('connected?');
    }
  });
}

class _WalletsDisplay extends StatelessWidget {
  final List<WalletApp> wallets;
  final BoxConstraints constraints;
  final Function(Uri) debugAction;
  const _WalletsDisplay({
    Key? key,
    required this.wallets,
    required this.constraints,
    required this.debugAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletApp tg = wallets.firstWhere(
      (wallet) => wallet.name == 'Wallet',
    );
    bool isThereTg = wallets.contains(tg);
    // List<WalletApp> elseWallets = wallets.remove
    List<WalletApp> _wallets = List.from(wallets);
    _wallets.remove(tg);

    return Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isThereTg) ...[
              GestureDetector(
                onTap: () async {
                  tonBloc.add(TonConnectWallet(app: tg));
                  final generatedUrl = await tonBloc.generateUrl(tg);
                  if (kDebugMode) {
                    debugAction(generatedUrl);
                  } else {
                    if (await canLaunchUrl(generatedUrl)) {
                      launchUrl(generatedUrl);
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: constraints.maxWidth - 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '👛 @wallet',
                        style:
                            context.styles.body1.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              )
            ],
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: _wallets.map((wallet) {
                return _WalletButton(
                    wallet: wallet,
                    constraints: constraints,
                    debugAction: debugAction);
              }).toList()),
            )
          ]),
    );
  }
}

class _WalletButton extends StatelessWidget {
  final WalletApp wallet;
  final BoxConstraints constraints;
  final Function(Uri) debugAction;
  const _WalletButton({
    Key? key,
    required this.wallet,
    required this.constraints,
    required this.debugAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        tonBloc.add(TonConnectWallet(app: wallet));
        final generatedUrl = await tonBloc.generateUrl(wallet);
        if (kDebugMode) {
          debugAction(generatedUrl);
        } else {
          if (await canLaunchUrl(generatedUrl)) {
            launchUrl(generatedUrl);
          }
        }
      },
      child: SizedBox(
        height: 110,
        width: 90,
        child: Padding(
            padding: const EdgeInsets.only(right: 4),
            // padding: const EdgeInsets.all(0).copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Container(
                      color: Colors.amber,
                    ),
                    // child: wallet.image.contains('mytonwallet')
                    //     // ? Image.asset('assets/mytonwallet.png')
                    //     ? Container(
                    //         color: Colors.red,
                    //       )
                    //     : Image.network(wallet.image),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(wallet.name,
                      style:
                          context.styles.body1.copyWith(color: Colors.white)),
                )
              ],
            )),
      ),
    );
  }
}
