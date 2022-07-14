//ランドリーの定義
import 'package:cloud_firestore/cloud_firestore.dart';

class Laundry {
  String post;
  Timestamp sendTime;
  String senderID;

  Laundry({required this.post, required this.sendTime, required this.senderID});
}