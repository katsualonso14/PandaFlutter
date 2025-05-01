import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/model/Auth.dart';
import 'package:test_flutter/model/post.dart';
import 'package:test_flutter/view/pages/bath_images.dart';
import 'package:test_flutter/view/parts/my_app_bar.dart';
import 'package:test_flutter/view_model/post_provider.dart';

class PostPage extends ConsumerWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPostIdProvider = ref.watch(myPostIdsProvider(Auth.myAccount?.uid ?? ""));
    return Scaffold(
      appBar: const MyAppBar(pageNumber: 0),
      body: myPostIdProvider.when(
        data: (postIds) {
          final postProvider = ref.watch(postDataProvider(postIds));
          return postProvider.when(
            data: (posts) {
              return ListView.builder(
                reverse: true,
                itemCount: posts!.length,
                itemBuilder: (context, index) {
                  Post _post = posts[index];
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
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const Center(child: Text('Error loading posts')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('Error loading post IDs')),
      ),
    );
  }
}
