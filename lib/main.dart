import 'package:students/pages/dashbord_page.dart';
import 'package:students/pages/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main ()=> runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  Future<void> login() async {
    // var user = await _auth.currentUser();
  }
  @override
  void initState() {
    login();
    super.initState();
//    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLogin ? DashBoard() : FirstPage());
  }
}


