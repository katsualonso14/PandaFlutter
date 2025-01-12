import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/presentation/pages/laundry_post_page.dart';
import 'package:test_flutter/presentation/pages/post_page.dart';
import 'package:test_flutter/presentation/pages/room_clean_page.dart';
import 'package:test_flutter/presentation/pages/todo_page.dart';
import 'package:test_flutter/presentation/parts/app_explain_dialog.dart';
import 'package:test_flutter/presentation/parts/my_ad_banner.dart';

class Navigation extends StatefulWidget {
  @override
  const Navigation({Key? key}) : super(key: key);

  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentIndex  = 0;
  bool _isFirstLaunch = false;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }

    setState(() {
      _isFirstLaunch = isFirstLaunch;
    });
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isFirstLaunch ? IndexedStack(
        index: _currentIndex,
        children: const [
          TodoPage(),
          RoomCleanPage(),
          PostPage(),
          LaundryPostPage(),
        ],
      ) : Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Icon(Icons.house, size: 70, color: Color.fromRGBO(128, 222, 250, 1)),
          ),
              const Text('Welcome to House Manager App!', style: TextStyle(fontSize: 20)),
              const Text('This app simplify your household tasks!', style: TextStyle(fontSize: 20)),
              const Text('This is an explanation of the app.', style: TextStyle(fontSize: 20)),
          const AppExplainDialog(),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  _isFirstLaunch = false;
                });
              },
              child: const Text('Start!')),
        ],
      )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAdBanner(),
          BottomNavigationBar(
            selectedItemColor: const Color.fromRGBO(128, 222, 250, 1),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'ToDo',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.house_outlined),
                  label: 'RoomClean'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bathtub),
                label: 'Bathroom',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_laundry_service),
                label: 'Laundry',
              ),
            ],
            currentIndex: _currentIndex,
            onTap: _onTap,
          ),
        ],
      ),
    );
  }
}
