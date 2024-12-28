import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/presentation/parts/my_app_bar.dart';

class RoomCleanPage extends HookWidget {
  const RoomCleanPage({Key? key}) : super(key: key);
  @override

  @override
  Widget build(BuildContext context) {
    var makeBedPoint = useState(0);
    var deskPoint = useState(0);
    var floorPoint = useState(0);
    var throwAwayCanPoint = useState(0);

    void setPrefData() async {
      final pref = await SharedPreferences.getInstance();
      pref.setInt('registerDate', DateTime.now().day);
      pref.setInt('makeBed', makeBedPoint.value);
      pref.setInt('desk', deskPoint.value);
      pref.setInt('floor', floorPoint.value);
      pref.setInt('throwAwayCan', throwAwayCanPoint.value);
    }

    void getPrefData() async {
      final pref = await SharedPreferences.getInstance();
      final setDate = pref.getInt('registerDate');
      // if the date is different, initialize the data to 0
      if(setDate != DateTime.now().day) {
        pref.setInt('makeBed', 0);
        pref.setInt('desk', 0);
        pref.setInt('floor', 0);
        pref.setInt('throwAwayCan', 0);
      }

      final makeBedPrefData = pref.getInt('makeBed');
      final deskPrefData = pref.getInt('desk');
      final floorPrefData = pref.getInt('floor');
      final throwAwayCanPrefData = pref.getInt('throwAwayCan');
      makeBedPoint.value = makeBedPrefData ?? 0;
      deskPoint.value = deskPrefData ?? 0;
      floorPoint.value = floorPrefData ?? 0;
      throwAwayCanPoint.value = throwAwayCanPrefData ?? 0;
    }

    useEffect(() {
      getPrefData();
      return () {};
    }, []);



    return Scaffold(
        appBar: const MyAppBar(pageNumber: 1),
        body: Column(
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                            i == 0 ? 'Make the Bed' : i == 1 ? 'Clean the Desk' :
                            i == 2 ? 'Clean the Floor' : 'Throw away a can',
                            style: const TextStyle(fontSize: 20)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            for(int y = 0; y < 3; y++)
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text(y == 0 ? 'No Action' : y == 1 ? 'Good' : 'Perfect'),
                                    Radio(
                                        value: y,
                                        groupValue: i == 0 ? makeBedPoint.value : i == 1 ?
                                        deskPoint.value : i == 2 ? floorPoint.value : throwAwayCanPoint.value,
                                        onChanged: (int? value) {
                                          if(value != null) {
                                            if(i == 0) {
                                              makeBedPoint.value = value;
                                            } else if(i == 1) {
                                              deskPoint.value = value;
                                            } else if(i == 2) {
                                              floorPoint.value = value;
                                            } else {
                                              throwAwayCanPoint.value = value;
                                            }
                                            // 毎回全部のデータを保存するか要確認
                                            setPrefData(); // SharedPreference(ios: UserDefault)にデータを保存
                                          }
                                        }),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}
