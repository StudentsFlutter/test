import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/pages/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

FirebaseUser user;
final FirebaseAuth _auth = FirebaseAuth.instance;

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  void _signInWithEmailAndPassword() async {
    user = (await _auth.signInWithEmailAndPassword(
            // email: _emailController.text,
            // password: _passwordController.text,
            email: "ffgggfffah@haha.com",
            password: "sssssssssss"))
        .user;

    if (user != null) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  // Future<void> firestore_reg() async {
  //   final snapshot = await _auth.currentUser;
  //
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   print("in store");
  //   print(snapshot.uid);
  //   await userRef.document("user.uid").setData({
  //     "Name": "name", // change to name controller
  //     "Email": "user.email", // change to email controller
  //     "PhoneNumber": "+966654544444", // change to phone controller
  //     "UserId": "user.uid", // change to user controller
  //     "isStd": true, // change to bool controller
  //   });
  // }

  firebase_auth_reg() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await _auth.createUserWithEmailAndPassword(
        // email: _emailController.text,
        // password: _passwordController.text,
        email: "fgffss@haha.com",
        password: "sssssssssss");
    if (user != null) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  void _register() async {
    await firebase_auth_reg();
    // await firestore_reg();
  }

  Future<void> login() async {
    // var user = await _auth.currentUser();
  }
  @override
  void initState() {
    // _register();
    // login();
    super.initState();
//    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLogin ? DashBoard() : FirstPage());
  }
}
