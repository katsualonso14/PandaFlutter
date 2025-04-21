
import 'package:test_flutter/model/firestore.dart';
import 'package:test_flutter/model/post.dart';

// 投稿ページのViewModel
class PostPageViewModel {
  final String uid;
  PostPageViewModel(this.uid);

  Stream<List<String>> myPostIdsStream() {
    return Firestore.getMyPostIds(uid);
  }

  Future<List<Post>?> fetchPosts(List<String> ids) {
    return Firestore.getPostFromIds(ids);
  }
}
