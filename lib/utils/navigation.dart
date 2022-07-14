import 'package:flutter/material.dart';
import 'package:test_flutter/pages/laundry_post_page.dart';
import 'package:test_flutter/pages/post_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
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
          PostPage(),
          LaundryPostPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
    );
  }
}
