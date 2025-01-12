import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/domain/entity/Auth.dart';
import 'package:test_flutter/domain/entity/firebase.dart';
import 'package:test_flutter/domain/entity/host_admin_user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController pwdInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(128, 222, 250, 1),
      ),
      body: registerScreen(),
    );
  }

  Widget registerScreen() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email*', hintText: "example@gmail.com"),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password*', hintText: "********"),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  const Padding(
                      padding: EdgeInsets.all(10.0)
                  ),
                  ElevatedButton(
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(128, 222, 250, 1),
                    ),
                    onPressed: () async {
                      // フォームが有効か否かチェック
                      if (_registerFormKey.currentState!.validate()) {
                        var result = await Auth.signUp(email: emailInputController.text, password: pwdInputController.text);
                        if(result is UserCredential) {
                          HouseAdminUser newUsers = HouseAdminUser(
                            uid: result.user!.uid,
                            email: emailInputController.text,
                          );
                          var _result = await Firestore.setUser(newUsers);
                          if (_result == true){
                            Navigator.pop(context);
                          }

                        }
                      }
                    },
                  ),
                ],
              ),
            )
        )
    );
  }

  //文字列チェック関数
  String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return '正しいEmailのフォーマットで入力してください';
    }
  }
  // ８文字以上をチェック
  String? pwdValidator(String? value) {
    if (value!.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    }
  }


}