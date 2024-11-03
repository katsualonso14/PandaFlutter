import 'package:flutter/material.dart';
import 'package:test_flutter/pages/laundry_post_page.dart';
import 'package:test_flutter/pages/my_ad_banner.dart';
import 'package:test_flutter/pages/post_page.dart';

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

  static const _screens = [
    PostPage(),
    LaundryPostPage(),
  ];

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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAdBanner(),
          BottomNavigationBar(
            items:  [
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
