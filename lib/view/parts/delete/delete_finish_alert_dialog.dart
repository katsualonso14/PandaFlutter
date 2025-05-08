
import 'package:flutter/material.dart';
import 'package:test_flutter/model/firebase/firebase_auth_service.dart';

Widget DeleteFinishAlertDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Success'),
    content: const Text('パスワードの確認が完了し、アカウントを削除いたしました。'),
    actions: [
      TextButton(
        onPressed: () async {
          // Firebaseアカウント削除
          FirebaseAuthService().deleteUserAccount();
          Navigator.pop(context);
        },
        child: const Text('OK'),
      ),
    ],
  );
}

