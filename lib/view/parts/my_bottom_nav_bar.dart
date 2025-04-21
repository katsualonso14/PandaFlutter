

import 'package:flutter/material.dart';
import 'package:test_flutter/view/parts/my_ad_banner.dart';

class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const MyBottomNavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const MyAdBanner(),
        BottomNavigationBar(
          selectedItemColor: const Color.fromRGBO(128, 222, 250, 1),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bathtub),
              label: 'Bathroom',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_laundry_service),
              label: 'Laundry',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'ToDo',
            ),
          ],
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ],
    );
  }
}
