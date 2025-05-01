import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_flutter/model/Auth.dart';
import 'package:test_flutter/model/laundry.dart';
import 'package:test_flutter/view/pages/laundry_images.dart';
import 'package:test_flutter/view/parts/my_app_bar.dart';
import 'package:test_flutter/view_model/laundry_post_provider.dart';

class LaundryPostPage extends ConsumerWidget {
  const LaundryPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laundryPostIdProvider = ref.watch(myLaundryPostIdsProvider(Auth.myAccount?.uid ?? ""));

    return Scaffold(
      appBar: const MyAppBar(pageNumber: 1),
      body: laundryPostIdProvider.when(
        data: (postIds) {
          final laundryPostProvider = ref.watch(laundryPostDataProvider(postIds));
          return laundryPostProvider.when(
            data: (posts) {
              return ListView.builder(
                reverse: true,
                itemCount: posts!.length,
                itemBuilder: (context, index) {
                  Laundry _laundryPost = posts[index];
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