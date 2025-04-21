
import 'package:flutter/material.dart';
import 'package:test_flutter/view/parts/app_explain_dialog.dart';

class WelcomePage extends StatelessWidget {
   final VoidCallback onStartPressed;
   const WelcomePage({Key? key, required this.onStartPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Icon(Icons.house, size: 70, color: Color.fromRGBO(128, 222, 250, 1)),
        ),
        const Text('Welcome to House Manager App!', style: TextStyle(fontSize: 20)),
        const Text('This app simplify your household tasks!', style: TextStyle(fontSize: 20)),
        const Text('This is an explanation of the app.', style: TextStyle(fontSize: 20)),
        const AppExplainDialog(),
        ElevatedButton(
            onPressed: onStartPressed,
            child: const Text('Start!')),
      ],
    ));
  }
}
