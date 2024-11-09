

import 'package:flutter/material.dart';
import 'package:test_flutter/utils/delete_func.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key, required this.buildContext}) : super(key: key);
  final BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Text('アカウント削除', style: TextStyle(color: Colors.blue)),
        onTap: () {
          showDialog(
              context: buildContext,
              builder: (context) {
                return AlertDialog(
                  title: const Text('アカウント削除'),
                  content: const Text('はいをタップするとアカウントが削除されます。\n本当に削除しますか？'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await DeleteFunc.deleteUserAccount(buildContext);
                        Navigator.pop(buildContext);
                      },
                      child: const Text('はい'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(buildContext);
                      },
                      child: const Text('いいえ'),
                    ),
                  ],
                );
              }
          );
        },
    );
  }
}
