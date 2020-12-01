import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/widgets/AppDrawer.dart';
import 'add_task_screen.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatelessWidget {
  // final String userName;
  //
  // const TasksScreen({Key key, this.userName}) : super(key: key);
  final TextEditingController taskController = TextEditingController();
  
  update(int index, String uid) async{
    CollectionReference doc = Firestore.instance.collection('$uid');
    QuerySnapshot qs = await doc.getDocuments();
    print(index);
    await qs.documents[index].reference.updateData({
    'done': !qs.documents[index]['done']});
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final userName = routeArgs['userName'];
    final uid = routeArgs['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
      ),
      drawer: AppDrawer(
        username: userName,
      ),
      floatingActionButton: AddTask(
        uid: uid,
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('$uid').snapshots(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = streamSnapshot.data.documents;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => update(index, uid),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: docs[index]['done']
                              ? Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                        ),
                      ),
                      title: Text(docs[index]['text']),
                      subtitle: Text(DateFormat('MMM dd, y hh:mm')
                          .format(DateTime.parse(docs[index]['timeAdded']))),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}


//() async => await Firestore.instance
//                       .collection('$uid')
//                       .document(docs[index].toString())
//                       .updateData({'done': !docs[index]['done']})