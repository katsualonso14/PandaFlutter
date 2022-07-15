import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/model/laundry.dart';
import 'package:test_flutter/pages/post_add_page.dart';
import 'package:test_flutter/utils/firebase.dart';
import 'package:intl/intl.dart' as intl;

class LaundryPostPage extends StatefulWidget {
  @override
  const LaundryPostPage({Key? key}) : super(key: key);
  _LaundryPostPage createState() => _LaundryPostPage();
}

class _LaundryPostPage extends State<LaundryPostPage> {
  List<Laundry> laundryList = [];
  final pageNumber = 1;
  //Firebaseデータ取得
  Future<void> getLaundryPost() async {
    laundryList = await Firestore.getLaundryPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //画面フラグ(pageNumber)を投稿追加ページに渡す
              Navigator.pushNamed(context, '/PostAddPage' ,arguments: pageNumber);
            },
            icon: Icon(Icons.edit),
          )
        ],
        title: Text('洗濯機'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("laundry").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //ネット不安定時にくるくるを表示
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return FutureBuilder(
            future: getLaundryPost(),
            builder: (context, snapshot) {
              return ListView.builder(
                reverse: true, //下からスクロール
                itemCount: laundryList.length,
                itemBuilder: (context, index) {
                  Laundry _laundryPost = laundryList[index];
                  DateTime sendTime = _laundryPost.sendTime.toDate();

                  return Card(
                    child: Column(
                      children: [
                        LaundryImages(),
                        ListTile(
                          title: Text(_laundryPost.senderID),
                          subtitle: Text(_laundryPost.post),
                          leading: Image.network('https://miro.medium.com/max/1400/0*vowtRZE_wvyVA7CB'),
                            trailing: Text(intl.DateFormat('MM/dd HH:mm').format(sendTime),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  //洗濯機画像UI設定
  Widget LaundryImages() {
    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('images/laundry.jpeg')
        ),
      ),
    );
  }
}