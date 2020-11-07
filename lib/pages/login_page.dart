import 'dart:ui';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:students/models/attendance.dart';
import 'package:students/models/class.dart';
import 'package:students/models/student_user.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/widgets/input_text_field.dart';

import 'Register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Scholar', fontSize: 20.0);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String password;
  String email;
  Future<List<Attendance>> getAttendaceList (List<String> attendaceIds) async {
     List<Attendance> attendaceList = [];
      for (String id in attendaceIds){
            final attendance = FirebaseFirestore.instance
            .collection('attendance')
            .doc(id);
             var doc = await attendance.get();
              List<String> studentsArray = doc['studentsArray'].cast<String>();
            String date = doc['date'];
            attendaceList.add(Attendance(id: attendance.id,studentsList: studentsArray,date: date));
      }
     return attendaceList;
  }
Future<List<Class>> getStudentCLasses(String uid, DocumentSnapshot doc) async {
      List<String> classesIds = doc['classesIds'].cast<String>();
       List<Class> classes = [];
      for (String id in classesIds) {
        final classesRef = FirebaseFirestore.instance
            .collection('classes')
            .doc(id);
            var nameDoc = await classesRef.get();
            String name = nameDoc['ClassName'];
            List<String> attendaceIds = nameDoc['attendaceIdsList'].cast<String>();
            classes.add(Class(name:name, id: classesRef.id,attendaceList:await getAttendaceList(attendaceIds)));

      }
      return classes;
}
  Future login() async {
    if (!formKey.currentState.validate()) return;
    setState(() {
      isLogin = true;
    });
    var user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (ex) {
      print(ex);
      user = null;
    }
    StudentUser userM;
    if (user != null) {
      DocumentSnapshot doc = await userRef.doc(user.uid).get();
      userM = StudentUser.fromDocument(doc,await getStudentCLasses(user.uid,doc),user.uid);
      setState(() {
        isLogin = false;
      });
    } else {
      setState(() {
        isLogin = false;
      });
      return;
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DashBoard(
            studentUser: userM,
            isFromRegister: false,
          ),
        ),
        (r) => false);
  }

  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.teal[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          login();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final rigesterButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.teal[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RegisterPage()));
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    Function validator = (value) {
      if (value.isEmpty) {
        return 'this field cant be empty';
      }
      return null;
    };
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: isLogin,
            child: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'QR attendance ',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            "assets/images/logo.Jpg",
                          ),
                          height: 100,
                          width: 200,
                          alignment: Alignment.center,
                        ),
                        InputTextField(
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: validator,
                        ),
                        InputTextField(
                          hintText: 'Password',
                          textInputType: TextInputType.visiblePassword,
                          isObscure: true,
                          onChanged: (value) {
                            password = value;
                          },
                          validator: validator,
                        ),
                        loginButton,
                        SizedBox(
                          height: 15.0,
                        ),
                        rigesterButton,
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
