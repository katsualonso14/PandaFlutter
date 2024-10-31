
import 'package:flutter/material.dart';

//お風呂画像UI設定
Widget BathImages() {
  return SizedBox(
    height: 150.0,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: FittedBox(
          fit: BoxFit.fitWidth, child: Image.asset('images/ofuro.jpeg')),
    ),
  );
}