import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter/domain/entity/host_admin_user.dart';

class Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static HouseAdminUser? myAccount;

  static Future<dynamic> signIn( {required String email, required String password}) async {
    try {
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password,);
      currentFirebaseUser = _result.user;
      // print('authサインイン完了'); //デバッグ用
      return _result;
    } on FirebaseException catch(e) {
      // print('auth登録エラー： $e'); //デバッグ用
      return '登録エラーしました';
    }
  }

  // Auth登録
  static Future<dynamic> signUp({required String email, required String password}) async {
    try {
      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // print('auth登録完了'); //デバッグ用
      return newAccount;
    } on FirebaseAuthException catch (e) {
      // print('auth登録失敗'); //デバッグ用
      return false;
    }
  }

  static Future<void> singOut() async{
    await _firebaseAuth.signOut();
  }
}