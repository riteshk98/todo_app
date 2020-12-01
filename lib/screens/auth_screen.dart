import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/controller/auth.dart' as au;
import 'package:todo_app/screens/tasks_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(height: 120,width: 160,
                child: Image(image: AssetImage('assets/images/logo.png'),),
              ),
              FlatButton.icon(icon: Icon(Icons.login),textColor: Colors.deepOrange,label: Text('Google Sign-in'),
                padding: EdgeInsets.zero,
                onPressed: () => au.signInGoogle().whenComplete(() async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();

                  Navigator.of(context).pushReplacementNamed('/tasks', arguments: {'userName' :user.displayName, 'id' : user.uid});
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
