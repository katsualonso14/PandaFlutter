
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  // ユーザーアカウント削除処理
  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print('error: $e');
    } catch (e) {
      print(e);
    }
  }


}