
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_flutter/parts/account_setting_button.dart';
import 'package:test_flutter/parts/app_explain_dialog.dart';

class TodoPage extends HookWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String rewardedAdId = 'ca-app-pub-5743090122530738/5284498763';
    var interstitialAd = useState<InterstitialAd?>(null);
    // control list Map
    ValueNotifier<List<Map<String, dynamic>>> todoContents = useState([
      {"task": "Take out the trash", "isChecked": false},
      {"task": "Do the laundry", "isChecked": false},
      {"task": "Wash the dishes", "isChecked": false},
      {"task": "Vacuum the house", "isChecked": false},
      {"task": "Clean the bathroom", "isChecked": false},
      {"task": "Mop the floor", "isChecked": false},
      {"task": "Wipe down the counters", "isChecked": false},
      {"task": "Fold the laundry", "isChecked": false},
    ]);

    void loadAd() {
      InterstitialAd.load(
        adUnitId: rewardedAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd.value = ad;
            interstitialAd.value!.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdDismissedFullScreenContent: (ad) {
                debugPrint('ad onAdDismissedFullScreenContent.');
                ad.dispose();
                loadAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                debugPrint('ad onAdFailedToShowFullScreenContent.');
                ad.dispose();
                loadAd();
              },
            );
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ),

      );
    }

    useEffect(() {
      loadAd();
      Future.delayed(const Duration(seconds: 4), () {
        if(interstitialAd.value != null) {
          interstitialAd.value!.show();
        }
      });

      return () {
        interstitialAd.value?.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
          showDialog(context: context, builder: (context) {
            return const AppExplainDialog();
          });
        },
            icon: const Icon(Icons.question_mark)),
        actions: [
          AccountSettingButton(context),
        ],
        title: const Text('Todo Page', style: TextStyle(color: Color.fromRGBO(128, 222, 250, 1))),
      ),
      body: ReorderableListView(
          padding: const EdgeInsets.all(8),
          children: [
            for (int index = 0; index < todoContents.value.length; index++)
             Card(
               key: Key('$index'),
               color: const Color.fromRGBO(201, 243, 255, 1),
               child: ListTile(
                title: Text(todoContents.value[index]["task"]),
                  leading: Checkbox(
                      value: todoContents.value[index]["isChecked"],
                      onChanged: (bool? value) {
                        final updatedList = List<Map<String, dynamic>>.from(todoContents.value);
                        updatedList[index]["isChecked"] = value ?? false;
                        todoContents.value = updatedList;
                      },
                    activeColor: const Color.fromRGBO(14, 159, 243, 1),
                      ),
                  trailing: const Icon(Icons.drag_handle),
               ),
             )
          ],
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final movedItem = todoContents.value.removeAt(oldIndex);
          final updatedList = List<Map<String, dynamic>>.from(todoContents.value); // copy list
          updatedList.insert(newIndex, movedItem);
          todoContents.value = updatedList; // update list
        },
      )
    );
  }
}
