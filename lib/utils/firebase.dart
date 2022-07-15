import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/post.dart';
import '../model/laundry.dart';

class Firestore {
  static final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  static final posts = _firebaseInstance.collection('posts');
  static final laundry = _firebaseInstance.collection('laundry');

  //お風呂投稿データ取得
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

  //洗濯機投稿データ取得
  static Future<List<Laundry>>getLaundryPost() async{
    List<Laundry> laundryPostList = [];
    final snapshot = await laundry.get();

    await Future.forEach<QueryDocumentSnapshot<Map<String, dynamic>>>(snapshot.docs, (doc){

      Laundry laundry = Laundry(
          post: doc.data()['content'],
          sendTime: doc.data()['sendTime'],
          senderID: doc.data()['senderID']
      );
      laundryPostList.add(laundry);
    });
    //時間順に並べる
    laundryPostList.sort((a,b) => b.sendTime.compareTo(a.sendTime));
    return laundryPostList;
  }

  //投稿追加
  static Future<void> submitPost(number,String content, String username) async {
    //お風呂画面から遷移してきた場合
    if (number == 0) {
      await posts.add({
        'content': content,
        'sendTime': Timestamp.now(),
        'senderID': username,
      });
    //洗濯機画面から遷移してきた場合
    } else if (number == 1) {
      await laundry.add({
        'content': content,
        'sendTime': Timestamp.now(),
        'senderID': username,
      });
    }
  }
}
