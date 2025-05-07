import 'package:flutter/material.dart';
import 'package:test_flutter/view/parts/delete_dialog.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key, required this.buildContext}) : super(key: key);
  final BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
              context: buildContext,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text('Are you sure you want to delete your account?'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context); // 先に今のダイアログを閉じる
                        await Future.delayed(const Duration(milliseconds: 300)); // ダイアログが閉じるのを待つ

                        showDialog(
                          context: buildContext,
                          builder: (dialogContext) {
                            return DeleteDialog(dialogContext, buildContext);
                          },
                        );
                      },

                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(buildContext);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              }
          );
        },
    );
  }
}
