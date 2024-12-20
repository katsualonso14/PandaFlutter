import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/parts/my_ad_banner.dart';
import 'package:test_flutter/pages/no_login_page.dart';
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
                decoration: const InputDecoration(labelText: "Mail Address"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
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
                  const TextSpan(text: 'Please create an home account '),
                  TextSpan(text: 'here',
                  style: const TextStyle(color: Colors.blue),
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
                      infoText = 'The email or password is incorrect.';
                    });
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 8),
              Text(infoText,
                style: const TextStyle(
                  color: Colors.red
                ),),
              OutlinedButton(
                  child: const Text('Check the page without log in', style: TextStyle(color: Colors.grey)),

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const NoLoginPage()));
                  }
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(30.0),
          child: MyAdBanner()),
    );
  }
}
