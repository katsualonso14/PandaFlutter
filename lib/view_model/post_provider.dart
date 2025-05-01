import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/model/firestore.dart';
import 'package:test_flutter/model/post.dart';

// 自分のポスト取得管理用Provider
final myPostIdsProvider = StreamProvider.family<List<String>, String>((ref, uid) {
  return Firestore.getMyPostIds(uid);
});

// idから取得した投稿データ管理用Provider
final postDataProvider = FutureProvider.family<List<Post>?, List<String>>((ref, ids) {
  return Firestore.getPostFromIds(ids);
});