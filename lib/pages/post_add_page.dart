import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/post.dart';
import '../utils/firebase.dart';


class PostAddPage extends StatefulWidget {
  const PostAddPage({Key? key}) : super(key: key);

  @override
  _PostAddPageState createState() => _PostAddPageState();
}

class _PostAddPageState extends State<PostAddPage> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _postTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String userName = '';
    String content = '';
    return Scaffold(
      appBar: AppBar(
        title: Text("投稿作成画面"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              // onSubmitted: _onSubmitted,
              onChanged: (value) {
                userName = value;
              },
              enabled: true,
              maxLength: 50, //入力数
              maxLengthEnforced: false,//入力上限の文字入力抑制
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.speaker_notes),
                hintText: '名前を記載します',
                labelText: '名前 *',
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
              maxLengthEnforced: false,//入力上限の文字入力抑制
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.speaker_notes),
                hintText: '投稿内容を記載します',
                labelText: '内容 *',
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Firestore.submitPost(content, userName);
                _textEditingController.clear();
                _postTextEditingController.clear();
              },
              child: Text('投稿'),
            )
          ]
        ),
      ),
    );
  }
}
