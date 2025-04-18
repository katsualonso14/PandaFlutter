import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/model/Auth.dart';
import 'package:test_flutter/model/laundry.dart';
import 'package:test_flutter/view/parts/my_app_bar.dart';
import 'package:test_flutter/view_model/laundry_post_page_view_model.dart';


class LaundryPostPage extends StatefulWidget {
  @override
  const LaundryPostPage({Key? key}) : super(key: key);
  _LaundryPostPage createState() => _LaundryPostPage();
}

class _LaundryPostPage extends State<LaundryPostPage> {
  final pageNumber = 1;
  final viewModel = LaundryPostPageViewModel(Auth.myAccount?.uid ?? ""); // 洗濯機ページ用のViewModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageNumber: pageNumber),
      body: StreamBuilder<List<String>>(
        stream: viewModel.myPostIdsStream(),
        builder: (context, snapshot) {
          //ネット不安定時にくるくるを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return FutureBuilder<List<Laundry>?>(
              future: viewModel.fetchPosts(snapshot.data!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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