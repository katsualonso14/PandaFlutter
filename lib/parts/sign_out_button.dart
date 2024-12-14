import 'package:flutter/material.dart';
import 'package:test_flutter/pages/signOutAlertDialog.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: const Text('Sign out', style: TextStyle(color: Colors.blue)),
        onTap: () {
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
