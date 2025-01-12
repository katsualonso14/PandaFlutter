import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/domain/entity/Auth.dart';
import 'package:test_flutter/domain/entity/firebase.dart';
import 'package:test_flutter/domain/entity/laundry.dart';
import 'package:test_flutter/presentation/parts/my_app_bar.dart';


class LaundryPostPage extends StatefulWidget {
  @override
  const LaundryPostPage({Key? key}) : super(key: key);
  _LaundryPostPage createState() => _LaundryPostPage();
}

class _LaundryPostPage extends State<LaundryPostPage> {
  final pageNumber = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageNumber: pageNumber),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.users.doc(Auth.myAccount?.uid).collection('myLaundryPosts').orderBy('sendTime', descending: true).snapshots(),
        builder: (context, snapshot) {
          //ネット不安定時にくるくるを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<String> myPostIds =
                List.generate(snapshot.data!.docs.length, (index) {
              return snapshot.data!.docs[index].id;
            });
            return FutureBuilder<List<Laundry>?>(
              future: Firestore.getLaundryPostFromIds(myPostIds),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print('myLaundryPostIds is $myPostIds');//　取得できず
                  return ListView.builder(
                    reverse: true, //下からスクロール
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Laundry _laundryPost = snapshot.data![index];
                      DateTime sendTime = _laundryPost.sendTime.toDate();

                      return Card(
                        child: Column(
                          children: [
                            LaundryImages(),
                            ListTile(
                              title: Text(_laundryPost.senderName),
                              subtitle: Text(_laundryPost.post),
                              leading: const SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/laundryicon.jpeg'),
                                  radius: 16,
                                ),
                              ),
                              trailing: Text(
                                intl.DateFormat('MM/dd HH:mm').format(sendTime),
                                style: const TextStyle(
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
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
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