import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';
import 'package:url_launcher/url_launcher.dart';

void showWalletsBottomSheet(BuildContext context, String text) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // String link = '';
          return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 0.2,
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
                              for (var wallet in tonState.availableWallets)
                                // print(wallet.toString());
                                SizedBox(
                                  height: 60,
                                  width: constraints.maxWidth / 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4)
                                        .copyWith(bottom: 16),
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.blue[600])),
                                      onPressed: () async {
                                        // print(tonState.connector?.connected);
                                        tonBloc
                                            .add(TonConnectWallet(app: wallet));
                                        final generatedUrl = await tonState
                                            .connector!
                                            .connect(wallet);
                                        // callback(generatedUrl);
                                        // print('Generated url: $generatedUrl');
                                        if (await canLaunchUrl(
                                            Uri.parse(generatedUrl))) {
                                          launchUrl(Uri.parse(generatedUrl));
                                        }
                                      },
                                      child: Text(
                                        wallet.name,
                                        style: context.styles.body1
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                            if (tonState.status == Status.loading) ...[
                              const SizedBox(
                                height: 32,
                              ),
                              // Center(
                              //   child: Container(
                              //     color: Colors.white,
                              //     child: QrImageView(
                              //       data: link,
                              //       version: QrVersions.auto,
                              //       size: 320,
                              //       gapless: false,
                              //     ),
                              //   ),
                              // )
                              const Center(child: CircularProgressIndicator())
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
  );
}
