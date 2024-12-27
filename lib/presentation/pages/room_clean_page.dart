import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_flutter/presentation/parts/my_app_bar.dart';

class RoomCleanPage extends HookWidget {
  const RoomCleanPage({Key? key}) : super(key: key);
  @override

  @override
  Widget build(BuildContext context) {
    var _groupValue = useState(0);
    var _groupValue2 = useState(0);
    var _groupValue3 = useState(0);
    var _groupValue4 = useState(0);

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
                                        groupValue: i == 0 ? _groupValue.value : i == 1 ?
                                        _groupValue2.value : i == 2 ? _groupValue3.value : _groupValue4.value,
                                        onChanged: (int? value) {
                                          if(value != null) {
                                            if(i == 0) {
                                              _groupValue.value = value;
                                            } else if(i == 1) {
                                              _groupValue2.value = value;
                                            } else if(i == 2) {
                                              _groupValue3.value = value;
                                            } else {
                                              _groupValue4.value = value;
                                            }
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
