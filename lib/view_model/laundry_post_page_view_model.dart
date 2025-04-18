
import 'package:test_flutter/model/firestore.dart';
import 'package:test_flutter/model/laundry.dart';

class LaundryPostPageViewModel {
  final String uid;
  LaundryPostPageViewModel(this.uid);

  Stream<List<String>> myPostIdsStream() {
    return Firestore.getMyLaundryPostIds(uid);
  }

  Future<List<Laundry>?> fetchPosts(List<String> ids) {
    return Firestore.getLaundryPostFromIds(ids);
  }
}