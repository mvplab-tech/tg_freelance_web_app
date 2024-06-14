import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tg_freelance/core/extensions/build_context_extension.dart';
import 'package:tg_freelance/core/status.dart';
import 'package:tg_freelance/core/widgets/buttons.dart';
import 'package:tg_freelance/features/ton/presentation/bloc/ton_bloc.dart';
import 'package:tg_freelance/features/ton/presentation/wallets_bottom_sheet.dart';
import 'package:tg_freelance/features/user/presentation/bloc/user_bloc.dart';

class CreateAccountPage extends StatefulWidget {
  // final String tgName;
  const CreateAccountPage({
    Key? key,
    // required this.tgName,
  }) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late TextEditingController nameController;
  bool nameIsOk = true;

  @override
  void initState() {
    nameController =
        TextEditingController(text: userbloc.state.authorizedUser.userName)
          ..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    nameController.removeListener(listener);
    nameController.dispose();
    super.dispose();
  }

  void listener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          String text = nameController.text.trim();
          nameIsOk = text.isNotEmpty && text.length >= 5;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello there,',
                  style: context.styles.header1,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    style: context.styles.header1
                        .copyWith(decoration: TextDecoration.underline),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Zа-яА-Я\s]'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            PulseButton(
              isLoading: userbloc.state.status == Status.loading,
              enabled: nameIsOk,
              text: nameIsOk
                  ? 'Name is ok, let\'s connect to TON'
                  : 'Name is not ok :(',
              action: () {
                if (kDebugMode) {
                  userbloc.add(
                    UserCreateNewUser(
                      name: nameController.text.trim(),
                    ),
                  );
                } else {
                  showWalletsBottomSheet(context, 'Connect to TON with:');
                  Timer.periodic(const Duration(milliseconds: 500), (t) {
                    if (tonBloc.state.status != Status.loading &&
                        tonBloc.state.account != null) {
                      userbloc.add(
                        UserCreateNewUser(
                          name: nameController.text.trim(),
                        ),
                      );
                      t.cancel();
                    }
                  });
                }
              },
            ),
            // Row()
          ],
        ),
      ),
    );
  }
}
