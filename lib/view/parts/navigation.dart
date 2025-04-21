import 'package:flutter/material.dart';
import 'package:test_flutter/view/pages/laundry_post_page.dart';
import 'package:test_flutter/view/pages/post_page.dart';
import 'package:test_flutter/view/pages/todo_page.dart';
import 'package:test_flutter/view/parts/my_bottom_nav_bar.dart';
import 'package:test_flutter/view/parts/welcome_page.dart';
import 'package:test_flutter/view_model/pref_view_model.dart';

class Navigation extends StatefulWidget {
  @override
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentIndex  = 0;
  bool _isFirstLaunch = false;
  final _prefViewModel = PrefViewModel();

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    bool isFirstLaunch = await _prefViewModel.checkFirstLaunch();
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
      body: !_isFirstLaunch
          ? IndexedStack(
              index: _currentIndex,
              children: const [
                PostPage(),
                LaundryPostPage(),
                TodoPage(),
              ],
            )
          : WelcomePage(
              onStartPressed: () {
                setState(() {
                  _isFirstLaunch = false;
                });
              },
            ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: _currentIndex, onTap: _onTap),
    );
  }
}
