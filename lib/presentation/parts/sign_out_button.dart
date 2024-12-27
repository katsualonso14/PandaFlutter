import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/pages/signOutAlertDialog.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (_) {
                // check if the user wants to sign out
                return const SignOutAlertDialog();
              });
        }
    );
  }
}
