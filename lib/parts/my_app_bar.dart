
import 'package:flutter/material.dart';
import 'package:test_flutter/parts/account_setting_button.dart';
import 'package:test_flutter/parts/app_explain_dialog.dart';
import 'package:test_flutter/parts/delete_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.pageNumber}) : super(key: key);
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: pageNumber == 0 ? IconButton(
          onPressed: (){
            showDialog(context: context, builder: (context) {
              return const AppExplainDialog();
            });
          },
          icon: const Icon(Icons.question_mark)
      ) : const SizedBox.shrink(),
      actions: [
        AccountSettingButton(context),
        pageNumber == 2 ? DeleteButton(buildContext: context): const SizedBox.shrink(),
        pageNumber != 0 ?
        IconButton(
          onPressed: () {
            pageNumber == 1 ? Navigator.pushNamed(context, '/PostAddPage' ,arguments: pageNumber)
                : Navigator.pushNamed(context, '/PostAddPage', arguments: pageNumber);
          },
          icon: const Icon(Icons.edit),
        ): const SizedBox.shrink(),
      ],
      title: Text(
          pageNumber == 0 ? 'Todo Page' : pageNumber == 1 ? 'Bathroom' : 'Laundry',
          style: const TextStyle(color: Color.fromRGBO(128, 222, 250, 1))
      ),
      centerTitle: true,
    );
  }

  // set the height of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
