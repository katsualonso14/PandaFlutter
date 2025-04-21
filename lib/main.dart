import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_flutter/view/pages/login.dart';
import 'package:test_flutter/view/parts/navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/view_model/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: authState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const Center(child: Text('認証エラー')),
          data: (user) {
            if (user == null) {
              return const LoginPage();
            }
            final userData = ref.watch(userDataProvider(user.uid));
            return userData.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
              const Center(child: Text('ユーザーデータエラー')),
              data: (_) {
                return Navigation();
              },
            );
          },
        ));
  }
}
