import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_flutter/pages/laundry_post_page.dart';
import 'package:test_flutter/pages/post_add_page.dart';
import 'package:test_flutter/pages/post_page.dart';
import 'package:test_flutter/pages/login.dart';
import 'package:test_flutter/pages/register_page.dart';
import 'package:test_flutter/utils/navigation.dart';
import 'utils/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter app',
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // スプラッシュ画面などに書き換えても良い
          return const SizedBox();
        }
        if (snapshot.hasData) {
            return FutureBuilder(
            future: Firestore.getUser(snapshot.data!.uid),
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
    ),
    routes: <String, WidgetBuilder>{
      '/postPage': (BuildContext context) => PostPage(),
      '/PostAddPage': (BuildContext context) => PostAddPage(),
      '/LaundryPostPage': (BuildContext context) => LaundryPostPage(),
      '/RegisterPage': (BuildContext context) => RegisterPage(),
    });
}
