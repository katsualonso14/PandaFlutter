//トークリスト
import 'package:flutter/material.dart';
import 'package:test_flutter/model/user.dart';
import 'package:test_flutter/pages/setting.dart';
import 'package:test_flutter/pages/talk_room.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
            onPressed: () {
                //画面遷移
                Navigator.push(context, MaterialPageRoute(builder: (context) => settingPage()));
            },
          )
        ],
      ),
      body: ListView.builder(
        //リストの数だけリストを表示する
        itemCount: userList.length,
        itemBuilder: (context, index) {
          //タップしたら処理をできるような処理
          return InkWell(
            onTap: (){
              //画面遷移
              Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoom(userList[index].name)));
            },
            child: Container(
              height: 70,
              child: Row(
                children: [
                  //リストの中身
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //アバターにユーザーリストのイメージを挿入
                    child: CircleAvatar(backgroundImage: NetworkImage(userList[index].imagePath),
                    radius: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userList[index].name, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text(userList[index].lastMessage, style: TextStyle(color: Colors.grey),),
                    ]
                  )

                ],
              ),
            ),
          );
      },
      ),
    );
  }
  @override

  //ユーザー情報
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
}
