import 'package:flutter/material.dart';

//洗濯機画像UI設定
Widget LaundryImages() {
  return SizedBox(
    height: 150.0,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Image.asset('images/laundry.jpeg')
      ),
    ),
  );
}