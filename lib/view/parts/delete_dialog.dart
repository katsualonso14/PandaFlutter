
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/view/parts/delete_finish_alert_dialog.dart';

Widget DeleteDialog(BuildContext dialogContext, BuildContext parentContext) {
  final TextEditingController passwordController = TextEditingController();

  return AlertDialog(
    title: const Text('削除するにはパスワードを入力してください'),
    content: TextField(
      controller: passwordController,
      decoration: const InputDecoration(labelText: 'Enter your password'),
      obscureText: true,
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(dialogContext);
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          // TODO: ここの責任はViewだけにするよう修正
          final password = passwordController.text;
          if (password.isNotEmpty) {
            Navigator.pop(dialogContext);
            Future.microtask(() {
              reauthenticateUser(parentContext, password);
            });
          } else {
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              const SnackBar(content: Text('Please enter a password')),
            );
          }
        },
        child: const Text('OK'),
      ),
    ],
  );
}

void reauthenticateUser(BuildContext parentContext, String password) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      String email = user.email!;
      final credential =
      EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
      
        showDialog(
          context: parentContext,
          builder: (builderContext) {
            return DeleteFinishAlertDialog(builderContext);
          },
        );
    } catch (e) {
      print('Re-authentication failed: $e');
    }
  }
}