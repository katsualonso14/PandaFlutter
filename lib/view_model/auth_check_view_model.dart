import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter/model/firestore.dart';

class AuthCheckViewModel {
  AuthCheckViewModel();

  // FirebaseのAuthチェック
  Stream<User?> checkAuthState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // FirebaseのUser情報取得
  Future<dynamic> getUser(String uid) {
    return Firestore.getUser(uid);
  }
}