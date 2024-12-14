import 'package:flutter/material.dart';
import 'package:test_flutter/pages/laundry_post_page.dart';
import 'package:test_flutter/pages/my_ad_banner.dart';
import 'package:test_flutter/pages/post_page.dart';
import 'package:test_flutter/pages/todo_page.dart';

class Navigation extends StatefulWidget {
  @override
  const Navigation({Key? key}) : super(key: key);

  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentIndex  = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          TodoPage(),
          PostPage(),
          LaundryPostPage(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAdBanner(),
          BottomNavigationBar(
            selectedItemColor:  const Color.fromRGBO(128, 222, 250, 1),
            items:  const [
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'Todo',
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
