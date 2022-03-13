//ログイン時ユーザ登録
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter/utils/shared_pref.dart';

class Firestore {
  static final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  //Userの定義
  static final userReference = _firebaseInstance.collection('user');
  //roomの定義
  static final roomReference = _firebaseInstance.collection('room');

  //ユーザの追加
  static Future<void> addUser() async{
   final newDoc = await userReference.add({
     'name': '名無し',
     'image_path': 'https://static.wikia.nocookie.net/disney3676/images/8/8c/Mickey_Mouse_.jpg/revision/latest?cb=20170822062457&path-prefix=ja'
   });
   print('アカウント作成完了');
   // await SharedPrefs.setUid(newDoc.id);


   //getUserで作られたIDを使えるようにする
   List<String> userIds = await getUser();

   userIds.forEach((user) async{
     //IDが自分じゃなければroomを作る
     if(user != newDoc.id) {
       await roomReference.add({
         'joined_user_ids': [user, newDoc.id],
         'updated_time': Timestamp.now()
       });
     }
   });
   print('ルーム作成完了');
  }
  //ユーザの取得
  //ユーザIDをリスト型でまとめる
  static Future<List<String>> getUser() async {
    try {
      final snapshot = await userReference.get();
      List<String> userIds = [];
      snapshot.docs.forEach((user) {
        userIds.add(user.id);
        print('${user.id}  ${user.data()['image_path']}');
      });

      return userIds;
    } catch(error) {
      final Null = null;
      print('${error}');
      return Null;
    }
  }
  

}