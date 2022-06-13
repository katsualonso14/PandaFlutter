//投稿の定義
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String post;
  Timestamp sendTime;
  String senderID;

  Post({required this.post, required this.sendTime, required this.senderID});
}