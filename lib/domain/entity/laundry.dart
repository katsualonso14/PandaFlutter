//ランドリーの定義
import 'package:cloud_firestore/cloud_firestore.dart';

class Laundry {
  String post;
  Timestamp sendTime;
  String houseID;
  String senderName;

  Laundry({required this.post, required this.sendTime, required this.houseID,  required this.senderName});
}