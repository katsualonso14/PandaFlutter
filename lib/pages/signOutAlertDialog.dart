import 'package:flutter/material.dart';

import '../utils/Auth.dart';
import 'login.dart';

class SignOutAlertDialog extends StatefulWidget {
  const SignOutAlertDialog({Key? key}) : super(key: key);

  @override
  _SignOutAlertDialogState createState() => _SignOutAlertDialogState();
}

class _SignOutAlertDialogState extends State<SignOutAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Are you sure you want to sign out?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(0),
        ),
        TextButton(
          child: Text('OK'),
          onPressed: (){
            Auth.singOut;
            while(Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => LoginPage()
            ));
          }
        ),
      ],
    );
  }
}

