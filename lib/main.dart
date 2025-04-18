import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_flutter/model/firestore.dart';
import 'package:test_flutter/view/pages/login.dart';
import 'package:test_flutter/view/parts/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
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
    ));
}
