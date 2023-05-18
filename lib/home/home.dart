import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController edit_textEditingController = TextEditingController();
  List tasks = ["demo"];

  addtask(List list, TextEditingController textEditingController) {
    setState(() {
      list.add(textEditingController.text);
      textEditingController.clear();
    });
  }

  delTask(List list, TextEditingController textEditingController, int index) {
    setState(() {
      list.removeAt(index);
    });
    const snackBar = SnackBar(
      content: Text('Task Deleted'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  editTask(List list, int index, BuildContext context) {
    Widget alert = AlertDialog(
      title: Text("Edit Task"),
      content: TextFormField(
        controller: edit_textEditingController,
      ),
      actions: [
        SizedBox(
          width: 100,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  list[index] = edit_textEditingController.text;
                });
                Navigator.pop(context);
                const snackBar = SnackBar(
                  content: Text("Task Edited Sucessfully"),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Save",
                  ),
                  Icon(Icons.save)
                ],
              )),
        )
      ],
    );
    edit_textEditingController.text = list[index];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: Container(
        child: Column(children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextFormField(
                      controller: textEditingController,
                    )),
                ElevatedButton(
                    onPressed: () {
                      addtask(tasks, textEditingController);
                    },
                    child: const Text(
                      "Add Task",
                    ))
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tasks[index],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            delTask(tasks, textEditingController, index);
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            editTask(tasks, index, context);
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  )
                ],
              );
            },
          )
        ]),
      ),
    ));
  }
}
