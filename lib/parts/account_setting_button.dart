

import 'package:flutter/material.dart';
import 'package:test_flutter/parts/delete_button.dart';
import 'package:test_flutter/parts/sign_out_button.dart';

class AccountSettingButton extends StatelessWidget {
  const AccountSettingButton(this.buildContext, {Key? key}) : super(key: key);
  final BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.account_circle_outlined),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Account Setting'),
                content: const Text(
                  'Please confirm logout or account deletion.',
                    style: TextStyle(color: Colors.black45)
                ),
                actions: [
                  const SignOutButton(),
                  DeleteButton(buildContext: buildContext),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
        });
  }
}
