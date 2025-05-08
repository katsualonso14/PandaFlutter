
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/view/parts/delete/delete_finish_alert_dialog.dart';

class DeleteViewModel extends ChangeNotifier {
  String errorMessage = '';

  Future<void> reauthenticateUser(BuildContext context, String password) async {
    if (password.isEmpty) {
      errorMessage = 'Please enter a password';
      notifyListeners(); // UI にエラーを通知
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String email = user.email!;
        final credential = EmailAuthProvider.credential(email: email, password: password);
        await user.reauthenticateWithCredential(credential);

          showDialog(
            context: context,
            builder: (context) {
              return DeleteFinishAlertDialog(context);
            },
          );
      } catch (e) {
        errorMessage = 'Re-authentication failed: $e';
        notifyListeners(); // UI にエラーを通知
      }
    }
  }
}