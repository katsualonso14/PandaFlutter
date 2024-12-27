import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter/domain/entity/Auth.dart';
import 'package:test_flutter/domain/entity/host_admin_user.dart';
import 'post.dart';
import 'laundry.dart';

class Firestore {
  static final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  static final posts = _firebaseInstance.collection('posts');
  static final laundry = _firebaseInstance.collection('laundry');
  static final users = _firebaseInstance.collection('users');

  //投稿追加
  static Future<dynamic> submitPost(number,String content, Post newPost) async {
    final CollectionReference _userPosts = _firebaseInstance.collection('users').doc(newPost.houseID).collection('myPosts');
    try {
        var result = await posts.add({
          'content': content,
          'sendTime': Timestamp.now(),
          'houseID': newPost.houseID,
          'senderName': newPost.senderName,
        });
        _userPosts.doc(result.id ).set({
          'post_id': result.id,
          'sendTime': Timestamp.now()
        });
      // print('投稿成功'); //デバッグ用
      return true;
    } on FirebaseException catch(e) {
      // print('投稿エラー: $e'); //デバッグ用
      return false;
    }
  }

  //投稿追加
  static Future<dynamic> submitLaundryPost(number,String content, Laundry newLaundryPost) async {
    final CollectionReference _userPosts = _firebaseInstance.collection('users').doc(newLaundryPost.houseID).collection('myLaundryPosts');
    try {
        var result = await laundry.add({
          'content': content,
          'sendTime': Timestamp.now(),
          'houseID': newLaundryPost.houseID,
          'senderName': newLaundryPost.senderName,
        });
        _userPosts.doc(result.id).set({
          'post_id': result.id,
          'sendTime': Timestamp.now()
        });
      // print('投稿成功'); //デバッグ用
      return true;
    } on FirebaseException catch(e) {
      // print('投稿エラー: $e'); //デバッグ用
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try{
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      HouseAdminUser myAccount = HouseAdminUser(
          uid: uid,
          email: data['email']
      );
      Auth.myAccount = myAccount;
      // print('ユーザ取得成功'); //デバッグ用
      return true;
    } on FirebaseException catch(e) {
      // print('ユーザ取得失敗: $e'); //デバッグ用
      return false;
    }
  }

  //Firestoreに登録
  static Future<dynamic> setUser (HouseAdminUser newUser) async {
    try {
      await users.doc(newUser.uid).set({
        'uid': newUser.uid,
        'email': newUser.email,
      });
      // print('新規ユーザ作成成功'); //デバッグ用
      return true;
    } on FormatException catch(e) {
      // print('新規ユーザ作成エラー'); //デバッグ用
      return false;
    }
  }
  //自分のID情報取得
  static Future<List<Post>?> getPostFromIds(List<String> ids) async {
    List<Post> postList = [];
    try{
      await Future.forEach(ids, (String id) async {
        var doc  = await posts.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
            post: data['content'],
            sendTime: data['sendTime'],
            senderName: data['senderName'],
            houseID: data['houseID']
        );
        postList.add(post);
      });
      // print('自分の投稿を表示'); //デバッグ用
      return postList;
    } on FirebaseException catch(e) {
      // print('自分の投稿取得失敗 $e'); //デバッグ用
      return null;
    }
  }

  //自分のID情報取得
  static Future<List<Laundry>?> getLaundryPostFromIds(List<String> ids) async {
    List<Laundry> LaundryPostList = [];
    try{
      await Future.forEach(ids, (String id) async {
        var doc  = await laundry.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Laundry laundryPost = Laundry(
            post: data['content'],
            sendTime: data['sendTime'],
            senderName: data['senderName'],
            houseID: data['houseID']
        );
        LaundryPostList.add(laundryPost);
      });
      // print('自分の投稿を表示'); //デバッグ用
      return LaundryPostList;
    } on FirebaseException catch(e) {
      // print('自分の投稿取得失敗 $e'); //デバッグ用
      return null;
    }
  }
}
