import 'package:darttonconnect/models/wallet_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';
import 'package:url_launcher/url_launcher.dart';

class Wallets extends StatelessWidget {
  const Wallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: BlocBuilder<TonBloc, TonState>(
        bloc: tonBloc,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getButtons(state.availableWallets, state),
          );
        },
      ),
    );
  }

  List<Widget> getButtons(List<WalletApp> wallets, TonState state) {
    List<Widget> tor = [];
    for (var wallet in wallets) {
      // print(wallet.toString());
      tor.add(Padding(
        padding: EdgeInsets.all(16),
        child: OutlinedButton(
          onPressed: () async {
            final generatedUrl = await state.connector!.connect(wallet);
            // print('Generated url: $generatedUrl');
            if (await canLaunchUrl(Uri.parse(generatedUrl))) {
              launchUrl(Uri.parse(generatedUrl));
            }
          },
          child: Text(wallet.name),
        ),
      ));
    }
    return tor;
  }
}
