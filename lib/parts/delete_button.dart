

import 'package:flutter/material.dart';
import 'package:test_flutter/utils/delete_func.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('アカウント削除'),
                content: const Text('はいをタップするとアカウントが削除されます。\n本当に削除しますか？'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await DeleteFunc.deleteUserAccount(context);
                      Navigator.pop(context);
                    },
                    child: const Text('はい'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
