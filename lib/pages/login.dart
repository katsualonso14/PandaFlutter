import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/my_ad_banner.dart';
import 'package:test_flutter/utils/Auth.dart';
import 'package:test_flutter/utils/firebase.dart';
import 'package:test_flutter/utils/navigation.dart';

class LoginPage extends StatefulWidget {
  @override
  const LoginPage({Key? key}) : super(key: key);
  _AuthPage createState() => _AuthPage();
}

class _AuthPage extends State<LoginPage> {
  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 入力されたメールアドレス（ログイン）
  String loginUserEmail = "";
  // 入力されたパスワード（ログイン）
  String loginUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min, //カラムの位置を調整できるように軸方向のサイズを最小に
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              RichText(text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: 'シェアハウスアカウントを作成していない方は'),
                  TextSpan(text: 'こちら',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer() ..onTap = () {
                    Navigator.pushNamed(context, '/RegisterPage');
                    })
                ]
              )),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  var result = await Auth.signIn(email: loginUserEmail, password: loginUserPassword);
                  if(result is UserCredential) {
                    var _result = await Firestore.getUser(result.user!.uid);
                    if(_result == true){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation()));
                    }
                  } else {
                    setState(() {
                      infoText = 'Eメールもしくはパスワードが違います。';
                    });
                  }
                },
                child: Text("ログイン"),
              ),
              const SizedBox(height: 8),
              Text(infoText,
                style: TextStyle(
                  color: Colors.red
                ),),
              const MyAdBanner()
            ],
          ),
        ),
      ),
    );
  }
}
