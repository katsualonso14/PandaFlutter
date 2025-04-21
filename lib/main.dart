import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_flutter/model/firestore.dart';
import 'package:test_flutter/view/pages/login.dart';
import 'package:test_flutter/view/parts/navigation.dart';
import 'package:test_flutter/view_model/auth_check_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final AuthCheckViewModel _authCheckViewModel = AuthCheckViewModel();
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,

    home: StreamBuilder<User?>(
      stream: _authCheckViewModel.checkAuthState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // スプラッシュ画面などに書き換えても良い
          return const SizedBox();
        }
        if (snapshot.hasData) {
            return FutureBuilder(
            future: _authCheckViewModel.getUser(snapshot.data!.uid),
            builder: (context, snapshot) {
              //処理呼び出し中はぐるぐるを表示
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                  ),
                );
              }
              if(snapshot.hasData) {
                return const Navigation();
              } else {
                return Container();
              }
            },
          );
        }
        // User が null である(未サインイン)の場合、サインイン画面へ
        return const LoginPage();
      },
    ));
}
