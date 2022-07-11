

import 'package:flutter/material.dart';
import 'package:test_flutter/pages/post_add_page.dart';

class LaundryPostPage extends StatefulWidget {
  @override
  const LaundryPostPage({Key? key}) : super(key: key);
  _LaundryPostPage createState() => _LaundryPostPage();
}

class _LaundryPostPage extends State<LaundryPostPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            //投稿作成画面へ遷移
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostAddPage())
                );
              },
              icon: Icon(Icons.edit),
            )
          ],
          title: Text('洗濯機'),
        ),
        body: Center(
        child: Text(
          'test',
          style: TextStyle(
            backgroundColor: Colors.red,
            color: Colors.black,
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}