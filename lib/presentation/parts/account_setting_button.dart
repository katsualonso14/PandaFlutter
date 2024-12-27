

import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/parts/sign_out_button.dart';

class AccountSettingButton extends StatelessWidget {
  const AccountSettingButton(this.buildContext, {Key? key}) : super(key: key);
  final BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Sign Out'),
                content: const Text(
                  'Are you sure you want to sign out?',
                    style: TextStyle(color: Colors.black45)
                ),
                actions: [
                  const SignOutButton(),
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
