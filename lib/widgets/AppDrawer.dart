import 'package:flutter/material.dart';
import 'package:todo_app/controller/auth.dart' as au;
import 'package:todo_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  final String username;

  const AppDrawer({Key key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(child: Text('To-do List',style: TextStyle(fontSize: 25),)),
          ListTile(title: Text('Welcome, '+ username),),
          ListTile(
            title: Text('Sign-out'),
            leading: Icon(Icons.logout),
            onTap: () {
              au
                  .signOutUser()
                  .whenComplete(() =>
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => AuthScreen()), (
                      Route<dynamic> route) => false));
                  },
          )
        ],
      ),
    );
  }
}
