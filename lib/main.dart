import 'package:flutter/material.dart';
import 'package:test_flutter/pages/top_page.dart';

void main() {
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