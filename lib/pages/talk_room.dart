import 'package:flutter/material.dart';
import 'package:test_flutter/model/message.dart';
import 'package:intl/intl.dart' as intl;

class TalkRoom extends StatefulWidget {
  final String name;
  TalkRoom(this.name);

  @override
  _TalkRoomState createState() => _TalkRoomState();
}

class _TalkRoomState extends State<TalkRoom> {
  List<Message> messageList = [
  Message(message: 'sample',
      isMe: true,
      sendTime: DateTime(2022, 2, 2, 11, 30)
  ),
    Message(message: 'text',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),

    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
    Message(message: '111qaafsdjksdfkjdskfjksdjfkjsdjkfksadjafsdkfsdjfkjsdkfjkdsjkfjsdjflsjdkfjdkjfsdfdsjkjsdkjfksjdf',
        isMe: true,
        sendTime: DateTime(2022, 2, 2, 11, 30)
    ),
    Message(message: 'textfsdjksdkljklfjlljlksdjkljklsdkfjksdjklfjsdlkffdsklfskdnffsdjjfksld',
        isMe: false,
        sendTime: DateTime(2022, 2, 2, 15, 30)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        //タイトルにユーザ名を指定
        title: Text(widget.name),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: ListView.builder(

                reverse: true, //したからスクロール設定
                itemCount: messageList.length,
                itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: index == 0 ? 10 : 0), //一番下のメッセージの場合bottomを開ける
                child: Row(
                  //時間を下に表示
                  crossAxisAlignment: CrossAxisAlignment.end,
                  //メッセージを自分かそれ以外で左右に分ける
                  textDirection: messageList[index].isMe ? TextDirection.rtl : TextDirection.ltr ,
                  children: [
                      Container(
                        //メッセージが画面幅の6割を超えたら文を折り返す
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            //メッセージの色を自分かそれ以外がで変える
                            color: messageList[index].isMe ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),

                          child: Text(messageList[index].message)),
                      Text(intl.DateFormat('HH:mm').format(messageList[index].sendTime)
                      , style: TextStyle(fontSize: 10)),
                  ],
                ),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                    ),
                  )),
                  IconButton(icon: Icon(Icons.send),
                    onPressed: () {
                    print('送信');
                    },)
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
