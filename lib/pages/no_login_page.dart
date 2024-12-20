import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_flutter/pages/bath_images.dart';
import 'package:test_flutter/parts/my_ad_banner.dart';
import 'package:test_flutter/pages/no_login_aleat_dialog.dart';

class NoLoginPage extends HookWidget {
  const NoLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const NoLoginAlertDialog();
                    });
              },
              icon: const Icon(Icons.edit),
            )
          ],
          title: const Text('Bath room'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios))),
      bottomNavigationBar: const Padding(child: MyAdBanner(),padding: EdgeInsets.all(30.0),),
      body: ListView(
        children: [
          for(int i = 0; i < 3; i++)
         Card(
          child: Column(
            children: [
              BathImages(),
              const ListTile(
                title: Text('Name'),
                subtitle: Text('Comment'),
                leading: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/duck2.jpeg'),
                    radius: 16,
                  ),
                ),
                trailing: Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
          // const SizedBox(height: 10),
          // const MyAdBanner()
        ],
      ),
    );
  }
}

