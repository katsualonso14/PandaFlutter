import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/view/pages/laundry_post_page.dart';
import 'package:test_flutter/view/pages/post_page.dart';
import 'package:test_flutter/view/pages/todo_page.dart';
import 'package:test_flutter/view/parts/my_bottom_nav_bar.dart';
import 'package:test_flutter/view/parts/welcome_page.dart';
import 'package:test_flutter/view_model/app_state_provider.dart';

class Navigation extends ConsumerWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstLaunch = ref.watch(firstLaunchProvider);
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);

    return firstLaunch.when(
        data: (isFirstLaunch) {
          return Scaffold(
            body: isFirstLaunch ?
            const WelcomePage() :
            IndexedStack(
              index: bottomNavIndex,
              children: const [
                PostPage(),
                LaundryPostPage(),
                TodoPage(),
              ],
            ),
            bottomNavigationBar: const MyBottomNavBar(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(child: Text('Error loading first launch state'))
    );
  }
}
