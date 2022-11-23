import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/pages/signOutAlertDialog.dart';
import 'package:test_flutter/pages/login.dart';
import 'package:test_flutter/utils/firebase.dart';
import '../model/post.dart';
import '../utils/Auth.dart';

class PostPage extends StatefulWidget {
  @override
  const PostPage({Key? key}) : super(key: key);
  _PostPage createState() => _PostPage();
}

class _PostPage extends State<PostPage> {
  final pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //画面フラグ(pageNumber)を投稿追加ページに渡す
              Navigator.pushNamed(context, '/PostAddPage' ,arguments: pageNumber);
            },
            icon: Icon(Icons.edit),
          )
        ],
        title: Text('お風呂'),
        leading:  IconButton(onPressed: (){
          showDialog<void>(
              context: context,
              builder: (_) {
                //サインアウト時は一度ダイアログで確認してから
                return SignOutAlertDialog();
              });
        },
            icon: Icon(Icons.arrow_back_ios))
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.users.doc(Auth.myAccount?.uid).collection('myPosts').orderBy('sendTime', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //ネット不安定時にくるくるを表示
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData){
            List<String> myPostIds = List.generate(snapshot.data!.docs.length, (index) {
              return snapshot.data!.docs[index].id;
            });
            return FutureBuilder<List<Post>?>(
              future: Firestore.getPostFromIds(myPostIds),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ListView.builder(
                    reverse: true, //下からスクロール
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Post _post = snapshot.data![index];
                      DateTime sendTime = _post.sendTime.toDate();

                      return Card(
                        child: Column(
                          children: [
                            BathImages(),
                            ListTile(
                              title: Text(_post.senderName),
                              subtitle: Text(_post.post),
                              leading: const SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('images/duck2.jpeg'),
                                  radius: 16,
                                ),
                              ),
                              trailing: Text(intl.DateFormat('MM/dd HH:mm').format(sendTime),
                                style: const TextStyle(
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
                } else {
                  return Container();
                }
              },
            );
          } else  {
            return Container();
          }
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