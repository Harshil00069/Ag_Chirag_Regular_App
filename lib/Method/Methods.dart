import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:treding/authentication/login_screen.dart';



Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": _auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
print("cc=> ${userCredential.user}");
    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}

Future<bool> checklogin()async{
  bool itslogin = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;

  if(user != null){
    itslogin = true;
  }
  return itslogin;
}



/*
Future<void> uploadingData(String userName, String usernumber,BuildContext context) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore.collection("products").add({
    'UserName': userName,
    'UserPhoneNumber': usernumber,
  }).then((value){
    Navigator.push(context, MaterialPageRoute(builder: (_) => const UserList()));
  });
}*/
