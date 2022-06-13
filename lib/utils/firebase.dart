import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/post.dart';
import '../model/user.dart';

class Firestore {
  static final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  static final posts = _firebaseInstance.collection('posts');


  //Firebaseのデータ取得
  static Future<List<Post>>getPost() async{
    List<Post> postList = [];
    final snapshot = await posts.get();

    await Future.forEach<QueryDocumentSnapshot<Map<String, dynamic>>>(snapshot.docs, (doc){

      Post post = Post(
          post: doc.data()['content'],
          sendTime: doc.data()['sendTime'],
          senderID: doc.data()['senderID']
      );
      postList.add(post);
    });
    //時間順に並べる
    postList.sort((a,b) => b.sendTime.compareTo(a.sendTime));
    return postList;
  }

  //投稿追加
  static Future<void> submitPost(String content) async {
    await posts.add({
      'content': content,
      'sendTime': Timestamp.now(),
      'senderID': 'ユーザ(仮)'
    });
  }

}
