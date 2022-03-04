import 'package:flutter/material.dart';
import 'package:test_flutter/model/user.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  List<User> userList = [
    User(name: 'onii',
        uid: 'aaa',
        imagePath: 'https://static.wikia.nocookie.net/disney3676/images/8/8c/Mickey_Mouse_.jpg/revision/latest?cb=20170822062457&path-prefix=ja',
        lastMessage: 'oissu'
    ),
    User(name: 'katsu',
        uid: 'bbb',
        imagePath: 'https://www.disney.co.jp/content/dam/disney/characters/disney_d_pixar/mickey_friends/Goofy_FC_ADULT_900_540_1.jpg',
        lastMessage: 'hello'
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
      ),
    );
  }
}
