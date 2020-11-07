import 'package:firebase_core/firebase_core.dart';
import 'package:students/models/attendance.dart';
import 'package:students/models/class.dart';
import 'package:students/models/student_user.dart';
import 'package:students/pages/attendance_page.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/pages/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students/pages/qr_code_generator.dart';
import 'package:students/pages/temp.dart';

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
      // home: isLoading ? Container() : isLogin ? DashBoard(
      // studentUser: StudentUser(
      //   email: 'rahaf@gmail.com',
      //   name:  'Rahaf Khaled',
      //   level:  '5',
      //   id: '30030',
      //   phoneNumber: '054863736',
      //   firebaseID: 'j7ejRAOqM9hjqqlNEhkUyuaUxLC2',
      // ),
      // ) : FirstPage()
      home: isLoading ? Container () : QrCodeGeneratorPage() ,
      // home : QrScannerPage( studentUser:
      //   StudentUser(
      //   email: 'rahaf@gmail.com',
      //   name:  'Rahaf Khaled',
      //   level:  '5',
      //   id: '30030',
      //   phoneNumber: '054863736',
      //   firebaseID: 'StudentUser'
      // ),
      // )
      // home: AttendancePage(
      //   studentUser: StudentUser(firebaseID: '1', classesList: [
      //     Class(name: 'test', attendaceList: [
      //       Attendace(studentsList: ['1'],date: '8/10/2020'),
      //       Attendace(studentsList: ['3'],date: '5/11/2020')
      //     ]),
      //     //  Class(name: 'test 2', attendaceList: [
      //     //   Attendace(studentsList: ['1']),
      //     //   Attendace(studentsList: ['3'])
      //     // ]),
      //     //  Class(name: 'test', attendaceList: [
      //     //   Attendace(studentsList: ['1']),
      //     //   Attendace(studentsList: ['3'])
      //     // ]),
      //   ]),
      // ),
    );
  }
}
