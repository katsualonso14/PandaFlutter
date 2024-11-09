import 'package:flutter/material.dart';
import 'package:test_flutter/pages/signOutAlertDialog.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: const Text('ログアウト', style: TextStyle(color: Colors.blue)),
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (_) {
                //サインアウト時は一度ダイアログで確認してから
                return const SignOutAlertDialog();
              });
        }
    );
  }
}
