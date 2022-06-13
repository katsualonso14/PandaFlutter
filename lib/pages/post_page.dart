import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/pages/post_add_page.dart';
import 'package:test_flutter/utils/firebase.dart';

import '../model/post.dart';
import '../model/user.dart';




class PostPage extends StatefulWidget {
  @override
  const PostPage({Key? key}) : super(key: key);
  _PostPage createState() => _PostPage();
}

class _PostPage extends State<PostPage> {
  List<User> userList = [];
  List<Post> postList = [];
  //Firebaseデータ取得
  Future<void> getPost() async {
    postList = await Firestore.getPost();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          //投稿作成画面へ遷移
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostAddPage())
              );
              print(userList);
            },
            icon: Icon(Icons.edit),
          )
        ],
        title: Text('お風呂'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //ネット不安定時にくるくるを表示
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return FutureBuilder(
            future: getPost(),
            builder: (context, snapshot) {
              return ListView.builder(
                reverse: true, //下からスクロール
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  Post _post = postList[index];
                  DateTime sendTime = _post.sendTime.toDate();

                  return Card(
                    child: Column(
                      children: [
                        BathImages(),
                        ListTile(
                          title: Text(_post.senderID),
                          subtitle: Text(_post.post),
                          leading: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKZhSeUQ9i1h-7Mkp5x4igIdW4kVS3Eo5PeZJS5nxvbZB2HLIVYXthSyrTqyMyGcjrzPw&usqp=CAU'),
                          trailing: Text(intl.DateFormat('MM/dd HH:mm').format(sendTime),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  //お風呂画像UI設定
  Widget BathImages() {
    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('images/ofuro.jpeg')
        ),
      ),
    );
  }

}