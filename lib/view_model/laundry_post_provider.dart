import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/model/firestore.dart';
import 'package:test_flutter/model/laundry.dart';

// 自分の洗濯ポスト取得管理用Provider
final myLaundryPostIdsProvider = StreamProvider.family<List<String>, String>((ref, uid) {
  return Firestore.getMyLaundryPostIds(uid);
});

// idから取得した洗濯投稿データ管理用Provider
final laundryPostDataProvider = FutureProvider.family<List<Laundry>?, List<String>>((ref, ids) {
  return Firestore.getLaundryPostFromIds(ids);
});