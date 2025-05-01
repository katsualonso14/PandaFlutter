import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/view/parts/app_explain_dialog.dart';
import 'package:test_flutter/view_model/app_state_provider.dart';

class WelcomePage extends ConsumerWidget {
   const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () async {
              // 初回起動フラグを更新
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isFirstLaunch', false);
              ref.invalidate(firstLaunchProvider);
            },
            child: const Text('Start!')),
      ],
    ));
  }
}
