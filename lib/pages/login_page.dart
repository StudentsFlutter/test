import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:students/pages/dashbord_page.dart';
//import 'package:flutter_all/teachers.dart';
import '../Register.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Scholar', fontSize: 20.0);
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';
  String username = '';

  Future login4() async {
     Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => DashBoard(),
                                      ),(r) => false);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final textField = TextField(
      controller: user,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      controller: pass,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.teal[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          login4();
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
                                  builder: (BuildContext context) => Register()
                                      ));
          
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: SafeArea(
              child: SingleChildScrollView(
                              child: Center(
          child: Container(
            color: Colors.white,
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
                    textField,
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(
                      height: 10.0,
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
    );
  }
}
