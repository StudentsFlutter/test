import 'package:firebase_core/firebase_core.dart';
import 'package:students/models/student_user.dart';
import 'package:students/pages/add_classes_page.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/pages/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

bool isLogin = false;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.teal),
        // home: isLogin ? DashBoard(
          //studentUser: StudentUser(
        //   email: 'rahaf@gmail.com',
        //   name:  'Rahaf Khaled',
        //   level:  '5',
        //   id: '30030',
        //   phoneNumber: '054863736'
        // ),) : FirstPage()
        home: SelectClassesPage(
 studentUser: StudentUser(
          email: 'rahaf@gmail.com',
          name:  'Rahaf Khaled',
          level:  '5',
          id: '30030',
          phoneNumber: '054863736')

        ),
        );
  }
}
