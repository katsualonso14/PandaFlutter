import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/laundry_post_page.dart';
import 'package:test_flutter/pages/post_add_page.dart';
import 'package:test_flutter/pages/post_page.dart';
import 'package:test_flutter/pages/auth_page.dart';
import 'package:test_flutter/utils/navigation.dart';
import 'model/post.dart';
import 'utils/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter app',
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // スプラッシュ画面などに書き換えても良い
          return const SizedBox();
        }
        if (snapshot.hasData) {
          // User が null でなない、つまりサインイン済みのホーム画面へ
          return Navigation();
        }
        // User が null である、つまり未サインインのサインイン画面へ
        return AuthPage();
      },
    ),
    routes: <String, WidgetBuilder>{
      '/postPage': (BuildContext context) => PostPage(),
      '/PostAddPage': (BuildContext context) => PostAddPage(),
      '/LaundryPostPage': (BuildContext context) => LaundryPostPage(),
    });
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: Navigation(),
  //       routes: <String, WidgetBuilder>{
  //         '/postPage': (BuildContext context) => PostPage(),
  //         '/PostAddPage': (BuildContext context) => PostAddPage(),
  //         '/LaundryPostPage': (BuildContext context) => LaundryPostPage(),
  //         '/AuthPage': (BuildContext context) => AuthPage(),
  //       });
  // }
}
