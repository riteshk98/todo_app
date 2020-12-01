import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

showErrDialog(BuildContext context, String err) {
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

Future<bool>signInGoogle() async {
  final googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await auth.signInWithCredential(credential);
    FirebaseUser user = await auth.currentUser();
    Firestore.instance.collection('users').document(user.uid).setData({'username' : user.displayName,'email' : user.email});
    return Future.value(true);
  }
  return Future.value(false);
}

Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  print(user.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await googleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}