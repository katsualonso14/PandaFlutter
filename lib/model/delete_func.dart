

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteFunc {

  static void _performSensitiveAction(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('パスワードの確認が完了し、アカウントを削除いたしました。'),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!.delete();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }



  static void _reauthenticateUser(BuildContext context, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        String email = user.email!;
        final credential = EmailAuthProvider.credential(email: email, password: password);
        await user.reauthenticateWithCredential(credential);

        _performSensitiveAction(context);

      } catch (e) {
        print('Re-authentication failed: $e');
      }
    }
  }

  static Future<void> _showPasswordDialog(BuildContext parentContext) async {
    final TextEditingController passwordController = TextEditingController();

    await showDialog(
      context: parentContext,  // Pass the context from the parent widget
      builder: (BuildContext context) {
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
                Navigator.pop(context);  // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final password = passwordController.text;
                if (password.isNotEmpty) {
                  Navigator.pop(context);  // Close the dialog
                  _reauthenticateUser(parentContext, password);  // Pass the parent context
                } else {
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    const SnackBar(content: Text('Please enter a password')),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  static Future<void> deleteUserAccount(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print('error: $e');
      await _showPasswordDialog(context);
    } catch (e) {
      print(e);
    }
  }

}