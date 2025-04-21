
import 'package:shared_preferences/shared_preferences.dart';

class PrefViewModel {

  // 初回起動かのチェック
  Future<bool> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }

    return isFirstLaunch;
  }
}