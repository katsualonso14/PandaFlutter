
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_flutter/presentation/parts/my_app_bar.dart';

class TodoPage extends HookWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // control list Map
    ValueNotifier<List<Map<String, dynamic>>> todoContents = useState([
      {"task": "Take out the trash", "isChecked": false},
      {"task": "Do the laundry", "isChecked": false},
      {"task": "Vacuum the house", "isChecked": false},
      {"task": "Clean the bathroom", "isChecked": false},
      {"task": "Mop the floor", "isChecked": false},
      {"task": "Wipe down the counters", "isChecked": false},
      {"task": "Fold the laundry", "isChecked": false},
    ]);
    var sliderValue = useState(0.0);
    return Scaffold(
      appBar: const MyAppBar(pageNumber: 0),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
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
                              sliderValue.value = todoContents.value.where((element) => element["isChecked"]).length.toDouble();
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
            ),
          ),
          Slider(
            value: sliderValue.value,
            onChanged: (double value) {},
            min: 0,
            max: 7,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.06 ,
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
              color: sliderValue.value == 8 ? const Color.fromRGBO(85, 222, 167, 1)
                  : sliderValue.value >= 1 ? const Color.fromRGBO(201, 243, 255, 1)
                  : Colors.white,
            ),
            child: Center(
              //TODO: Add tap act that use can rest todo check box
              child: Text(
                "Progress on todo is "
                    "${sliderValue.value == 7 ? 'Perfect!' : sliderValue.value >= 1 ? 'Good ' : 'No Action'}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
