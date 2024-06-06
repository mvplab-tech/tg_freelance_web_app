import 'package:darttonconnect/models/wallet_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_state.dart';
import 'package:url_launcher/url_launcher.dart';

class Wallets extends StatefulWidget {
  const Wallets({super.key});

  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  String link = '';

  void setLink(String inc) {
    setState(() {
      link = inc;
    });
  }

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
              children: [
                if (link.isNotEmpty)
                  QrImageView(
                    data: link,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                  ),
                ...getButtons(state.availableWallets, state, setLink),
              ]);
        },
      ),
    );
  }

  List<Widget> getButtons(
      List<WalletApp> wallets, TonState state, Function(String) callback) {
    List<Widget> tor = [];
    for (var wallet in wallets) {
      // print(wallet.toString());
      tor.add(Padding(
        padding: EdgeInsets.all(16),
        child: OutlinedButton(
          onPressed: () async {
            final generatedUrl = await state.connector!.connect(wallet);
            callback(generatedUrl);
            // print('Generated url: $generatedUrl');
            // if (await canLaunchUrl(Uri.parse(generatedUrl))) {
            //   launchUrl(Uri.parse(generatedUrl));
            // }
          },
          child: Text(wallet.name),
        ),
      ));
    }
    return tor;
  }
}
