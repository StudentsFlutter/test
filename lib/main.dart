import 'package:firebase_core/firebase_core.dart';
import 'package:students/models/student_user.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/pages/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    init();
    super.initState();
  }
bool isLogin = false;
bool isLoading = true;
Future<void> init() async {
    await Firebase.initializeApp();
    
    
    setState(() {
      isLoading = false;
    });
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: isLoading ? Container() : isLogin ? DashBoard(
      studentUser: StudentUser(
        email: 'rahaf@gmail.com',
        name:  'Rahaf Khaled',
        level:  '5',
        id: '30030',
        phoneNumber: '054863736'
      ),) : FirstPage()
      // home: :SelectClassesPage(
      //     studentUser: StudentUser(
      //         email: 'rahaf@gmail.com',
      //         name: 'Rahaf Khaled',
      //         level: '5',
      //         id: '30030',
      //         phoneNumber: '054863736',
      //         classesList: [Class(name: 'math', id :'Math101'),],
              
      //         ),),
    );
  }
}
