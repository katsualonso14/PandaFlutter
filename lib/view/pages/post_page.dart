import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/model/Auth.dart';
import 'package:test_flutter/model/post.dart';
import 'package:test_flutter/view/pages/bath_images.dart';
import 'package:test_flutter/view/parts/my_app_bar.dart';
import 'package:test_flutter/view_model/post_page_view_model.dart';

class PostPage extends StatefulWidget {
  @override
  const PostPage({Key? key}) : super(key: key);
  @override
  _PostPage createState() => _PostPage();
}

class _PostPage extends State<PostPage> {
  final pageNumber = 0;
  final viewModel = PostPageViewModel(Auth.myAccount?.uid ?? ""); // 投稿ページ用のViewModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageNumber: pageNumber),
      body: StreamBuilder<List<String>>(
        stream: viewModel.myPostIdsStream(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          //ネット不安定時にくるくるを表示
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData){
            return FutureBuilder<List<Post>?>(
              future: viewModel.fetchPosts(snapshot.data!),
              builder: (context, postSnapshot) {
                if(postSnapshot.hasData) {
                  return ListView.builder(
                    reverse: true, //下からスクロール
                    itemCount: postSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      Post _post = postSnapshot.data![index];
                      DateTime sendTime = _post.sendTime.toDate();
                      return Card(
                        child: Column(
                          children: [
                            BathImages(),
                            ListTile(
                              title: Text(_post.senderName),
                              subtitle: Text(_post.post),
                              leading: const SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('images/duck2.jpeg'),
                                  radius: 16,
                                ),
                              ),
                              trailing: Text(intl.DateFormat('MM/dd HH:mm').format(sendTime),
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
          } else  {
            return Container();
          }
        },
      ),
    );
  }
}