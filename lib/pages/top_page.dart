//トークリスト
import 'package:flutter/material.dart';
import 'package:test_flutter/model/talk_room.dart';
import 'package:test_flutter/model/user.dart';
import 'package:test_flutter/pages/setting.dart';
import 'package:test_flutter/pages/talk_room.dart';
import 'package:test_flutter/utils/shared_pref.dart';

import '../utils/firebase.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  //ユーザー情報
  List<TalkRoom> userList = [];

  Future<void> createRoom() async {
    String myUid = SharedPrefs.getUid();
    userList = await Firestore.getRoom(myUid);
  }
  @override
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
      body: FutureBuilder(
        future: createRoom(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              //リストの数だけリストを表示する
              itemCount: userList.length,
              itemBuilder: (context, index) {
                //タップしたら処理をできるような処理
                return InkWell(
                  onTap: (){
                    //画面遷移
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoomPage(userList[index].talkUser)));
                  },
                  child: Container(
                    height: 70,
                    child: Row(
                      children: [
                        //リストの中身
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //アバターにユーザーリストのイメージを挿入
                          child: CircleAvatar(backgroundImage: NetworkImage(userList[index].talkUser.imagePath),
                            radius: 30,
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(userList[index].talkUser.name, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text('userList[index].lastMessage', style: TextStyle(color: Colors.grey),),
                            ]
                        )

                      ],
                    ),
                  ),
                );
              },
            );
          } else {
              return Center(child: CircularProgressIndicator());
          }

        }
      ),
    );
  }



}
