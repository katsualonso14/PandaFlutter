import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/top_page.dart';
import 'package:test_flutter/utils/firebase.dart';
import 'package:test_flutter/utils/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await SharedPrefs.setInstance();
  Firestore.addUser();
  runApp(myApp());

}

class myApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopPage(),
    );
  }
}