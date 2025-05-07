import 'package:flutter/material.dart';
import 'package:test_flutter/view_model/delete_view_model.dart';

Widget DeleteDialog(BuildContext dialogContext, BuildContext parentContext) {
  final TextEditingController passwordController = TextEditingController();
  final deleteViewModel = DeleteViewModel();

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
        onPressed: () async {
          Navigator.pop(dialogContext); // 先に今のダイアログを閉じる
          await Future.delayed(const Duration(milliseconds: 300)); // ダイアログが閉じるのを待つ
          // テスト対象にするならViewModelへの分離も検討
          final password = passwordController.text;
          if (password.isNotEmpty) {
            deleteViewModel.reauthenticateUser(parentContext, password);
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