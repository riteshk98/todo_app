import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: () =>
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => AddTaskScreen()
                  )),
            child: ListTile(
              title: Text('Task'),
            ),
          );
        },
      ),
    );
  }
}
