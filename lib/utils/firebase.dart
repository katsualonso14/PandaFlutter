//ログイン時ユーザ登録
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter/model/talk_room.dart';
import 'package:test_flutter/model/user.dart';
import 'package:test_flutter/utils/shared_pref.dart';

class Firestore {
  static final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  //Userの定義
  static final userReference = _firebaseInstance.collection('user');
  //roomの定義
  static final roomReference = _firebaseInstance.collection('room');
  static final roomSnapshot = roomReference.snapshots();

  //ユーザの追加
  static Future<void> addUser() async{
   final newDoc = await userReference.add({
     'name': '名無し',
     'image_path': 'https://static.wikia.nocookie.net/disney3676/images/8/8c/Mickey_Mouse_.jpg/revision/latest?cb=20170822062457&path-prefix=ja'
   });
   print('アカウント作成完了');

   print(newDoc.id);
   await SharedPrefs.setUid(newDoc.id);
   String uid = SharedPrefs.getUid();
   print(uid);

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

  //自分の情報をとってくる
  static Future<String> getProfile(String uid) async {
    final profile = await userReference.doc(uid).get();
    final FirebaaseData = profile.data()!;
    User myProfile = User(
        name: FirebaaseData['name'],
        uid: uid,
        imagePath: FirebaaseData['image_path'],
    );
    print('getProfile実行');
    return uid;
  }
  static Future<List<TalkRoom>> getRoom(String myUid) async {
    final snapshot = await roomReference.get();
    List<TalkRoom> roomList = [];
   //肩を明示的に宣言する必要がある　nullエラーになるため
    await Future.forEach<QueryDocumentSnapshot<Map<String, dynamic>>>(snapshot.docs, (doc) async {
           if(doc.data()['joined_user_ids'].contains(myUid)) {
             //相手のID
             String? yourUid;
             doc.data()['joined_user_ids'].forEach((id){
               if(id != myUid) {
                 yourUid = id;
                 return;
               }
             });
             

             User yourProfile = (await getProfile(yourUid!)) as User;

             TalkRoom room = TalkRoom(
                 roomId: doc.id,
                 talkUser: yourProfile,
                 lastMessage: doc['last_message'] ?? ''
             );
             roomList.add(room);
           }
    });
    print('roomList.length: ${roomList.length}');
    return roomList;
  }
}