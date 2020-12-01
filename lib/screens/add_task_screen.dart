import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  final String uid;

  const AddTask({Key key, @required this.uid}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String task = '';

  void showAlertDialog(BuildContext bc) {
    String id = widget.uid;
    showDialog(
        context: bc,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Enter to-do'),
            content: TextField(
              onChanged: (val) {
                setState(() {
                  task = val;
                });
              },
            ),
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.add),
                onPressed: () async {
                  if (task.trim().isEmpty) {
                    return;
                  }
                  print('task' + widget.uid + '//' + id);
                  await Firestore.instance.collection('$id').add({
                    'text': task,
                    'timeAdded': DateTime.now().toIso8601String(),
                    'done': false
                  });

                  Navigator.of(ctx).pop();
                },
                label: Text('Submit'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showAlertDialog(context),
      child: Icon(Icons.add),
    );
  }
}
