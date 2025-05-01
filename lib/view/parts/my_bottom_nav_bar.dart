import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/view/parts/my_ad_banner.dart';
import 'package:test_flutter/view_model/app_state_provider.dart';

class MyBottomNavBar extends ConsumerWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
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
          onTap: (index) {
            ref.read(bottomNavIndexProvider.notifier).state = index;
          },
        ),
      ],
    );
  }
}
