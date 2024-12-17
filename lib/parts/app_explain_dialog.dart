import 'package:flutter/material.dart';

class AppExplainDialog extends StatelessWidget {
  const AppExplainDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = [
      const Image(image: AssetImage('images/todo_image.PNG'), height: 250),
      const Image(image: AssetImage('images/todo_image2.PNG'), height: 250),
      const Image(image: AssetImage('images/add_post.png'), height: 250),
      const Image(image: AssetImage('images/bathroom_image.PNG'), height: 250),
      const Image(image: AssetImage('images/laundry_image.png'), height: 250),
    ];

    var explainTexts = [
      'You can see the todo list here.',
      'You can drag and drop the todo list to change the order.',
      'Add your post by clicking the edit button on the top right of the screen.',
      'You can see the posts you have added here.',
      'You can see the laundry list here.',
    ];

    return Dialog(
      child: SizedBox(
        height: 400,
        child: ListView(
            scrollDirection: Axis.horizontal,
            itemExtent: 300,
            children: images.map((Image image) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    image,
                    const SizedBox(height: 50),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(128, 222, 250, 1),
                            width: 2.5
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 50,
                        child: Center(
                            child: Text(explainTexts[images.indexOf(image)])
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }).toList()),
      ),
    );
  }
}
