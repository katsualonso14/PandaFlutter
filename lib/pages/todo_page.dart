
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_flutter/parts/account_setting_button.dart';
import 'package:test_flutter/parts/app_explain_dialog.dart';
import 'package:test_flutter/parts/delete_button.dart';

class TodoPage extends HookWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
