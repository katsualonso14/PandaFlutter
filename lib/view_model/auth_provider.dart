import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test_flutter/model/firestore.dart';

  // FirebaseのAuthチェック
  final authStateProvider = StreamProvider<User?>((ref) {
    return FirebaseAuth.instance.authStateChanges();
  });

  // FirebaseのUser情報取得
  final userDataProvider = FutureProvider.family<dynamic, String>((ref, uid) {
    return Firestore.getUser(uid);
  });