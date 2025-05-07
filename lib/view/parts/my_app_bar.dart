
import 'package:flutter/material.dart';
import 'package:test_flutter/view/pages/post_add_page.dart';
import 'package:test_flutter/view/parts/app_explain_dialog.dart';
import 'package:test_flutter/view/parts/delete/delete_button.dart';
import 'package:test_flutter/view/parts/sign_out_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.pageNumber}) : super(key: key);
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    const titles = ['Bathroom', 'Laundry', 'Todo'];
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
        if(pageNumber == 2) const SignOutButton(),
        if(pageNumber == 2) DeleteButton(buildContext: context),
        if(pageNumber == 0 || pageNumber == 1)
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const PostAddPage(),
              // 共通Widgetに渡すページ番号を指定
              settings: RouteSettings(
                arguments: pageNumber,
              ),
            ));
          },
          icon: const Icon(Icons.edit),
        ),
      ],
      title: Text(
          titles[pageNumber],
          style: const TextStyle(color: Color.fromRGBO(128, 222, 250, 1))
      ),
      centerTitle: true,
    );
  }

  // set the height of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
