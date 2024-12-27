import 'package:flutter/material.dart';
import 'package:test_flutter/domain/entity/delete_func.dart';

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
                        await DeleteFunc.deleteUserAccount(buildContext);
                        Navigator.pop(buildContext);
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
