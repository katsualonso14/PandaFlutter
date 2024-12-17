import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/model/laundry.dart';
import 'package:test_flutter/pages/my_ad_banner.dart';
import 'package:test_flutter/utils/Auth.dart';

import '../model/post.dart';
import '../utils/firebase.dart';


class PostAddPage extends StatefulWidget {
  const PostAddPage({Key? key}) : super(key: key);

  @override
  _PostAddPageState createState() => _PostAddPageState();
}

class _PostAddPageState extends State<PostAddPage> {
  //各画面のTextController
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _postTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userName = '';
    String content = '';
    //各画面から受け取った画面フラグ
    final pageNumber = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Page"),
      ),
      // bottomNavigationBar: Padding(child: Container(),padding: const EdgeInsets.all(30.0),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                userName = value;
              },
              enabled: true,
              maxLength: 50, //入力数
              maxLengthEnforcement: MaxLengthEnforcement.enforced,//入力上限の文字入力抑制
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.speaker_notes),
                hintText: 'Write your name',
                labelText: 'Name *',
              ),
            ),
            TextField(
              controller: _postTextEditingController,
              // onSubmitted: _onSubmitted,
              onChanged: (value) {
                content = value;
              },
              enabled: true,
              maxLength: 50, //入力数
              maxLengthEnforcement: MaxLengthEnforcement.enforced,//入力上限の文字入力抑制
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.speaker_notes),
                hintText: 'Write your post',
                labelText: 'post *',
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              onPressed: () async {

                if (pageNumber == 0) {
                  //投稿画面のタップ時にFirestoreに登録
                  Post newPost = Post(
                      post: content,
                      sendTime: Timestamp.now(),
                      senderName: userName,
                      houseID: Auth.myAccount!.uid
                  );
                  var result = await Firestore.submitPost(pageNumber,content, newPost);
                  if(result == true) {
                    _textEditingController.clear();
                    _postTextEditingController.clear();
                    Navigator.pop(context);
                  }
                } else if(pageNumber == 1) {
                  Laundry newLaundryPost = Laundry(
                      post: content,
                      sendTime: Timestamp.now(),
                      senderName: userName,
                      houseID: Auth.myAccount!.uid
                  );
                  var result = await Firestore.submitLaundryPost(pageNumber,content, newLaundryPost);
                  if(result == true) {
                    _textEditingController.clear();
                    _postTextEditingController.clear();
                    Navigator.pop(context);
                  }
                }

              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 30),
            const MyAdBanner(),
          ]
        ),
      ),
    );
  }
}