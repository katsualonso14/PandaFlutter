// トーク画面
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/model/message.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/model/talk_room.dart';
import 'package:test_flutter/model/user.dart';
import 'package:test_flutter/utils/firebase.dart';

class TalkRoomPage extends StatefulWidget {
  final TalkRoom room;
  TalkRoomPage(this.room);

  @override
  _TalkRoomPageState createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  List<Message> messageList = [];
  TextEditingController controller = TextEditingController();

  Future<void> getMessage() async {
      messageList = await Firestore.getMessage(widget.room.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        //タイトルにユーザ名を指定
        title: Text(widget.room.talkUser.name),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.messageSnapshot(widget.room.roomId),
              builder: (context, snapshot) {
                return FutureBuilder(
                  future: getMessage(),
                  builder: (context, snapshot) {
                    return ListView.builder(

                        reverse: true, //したからスクロール設定
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          Message _message = messageList[index];
                          DateTime sendTime = _message.sendTime.toDate();
                          return Padding(
                            padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: index == 0 ? 10 : 0), //一番下のメッセージの場合bottomを開ける
                            child: Row(
                              //時間を下に表示
                              crossAxisAlignment: CrossAxisAlignment.end,
                              //メッセージを自分かそれ以外で左右に分ける
                              textDirection: _message.isMe ? TextDirection.rtl : TextDirection.ltr ,
                              children: [
                                Container(
                                  //メッセージが画面幅の6割を超えたら文を折り返す
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      //メッセージの色を自分かそれ以外がで変える
                                        color: _message.isMe ? Colors.green : Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text(_message.message)),
                                Text(intl.DateFormat('HH:mm').format(sendTime)
                                    , style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          );
                        }
                    );
                  }
                );
              }
            ),
          ),
          //入力欄
          Align(
            //画面下に表示
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60, color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                    ),
                  )),
                  IconButton(icon: Icon(Icons.send),
                    onPressed: () async{
                    print('送信');

                      if (controller.text.isNotEmpty) {
                        await Firestore.sendMessage(
                            widget.room.roomId, controller.text);
                        controller.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
