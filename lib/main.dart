import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_flutter/pages/auth.dart';
import 'package:test_flutter/pages/setting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new MainPage(),
        '/authpage': (BuildContext context) => new AuthPage(),
        '/settingpage': (BuildContext context) => new SettingPage()
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Navigator'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Text('Main'),
              RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed("/authpage"),
                child: new Text('Authページへ'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed("/settingpage"),
                child: new Text('Settingページへ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
