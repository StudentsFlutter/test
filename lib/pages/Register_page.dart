import 'dart:ui';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/widgets/input_text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Scholar', fontSize: 20.0);
  String id;
  String name;
  String email;
  String phoneNumber;
  String level;
  String password;
  bool isRegistering = false;

  Future register() async {
    if (!formKey.currentState.validate()) return;
    setState(() {
      isRegistering = true;
    });
    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (ex) {
      user = null;
    }
    if (user != null) {
      setState(() {
        isRegistering = false;
      });
    } else {
      setState(() {
        isRegistering = false;
      });
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashBoard()),
    );
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.teal[200],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          register();
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final cancelButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.teal[200],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text("CANCEL",
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
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isRegistering,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InputTextField(
                          hintText: 'ID',
                          onChanged: (value) {
                            id = value;
                          },
                          validator: validator,
                        ),
                        InputTextField(
                          hintText: 'Name',
                          onChanged: (value) {
                            name = value;
                          },
                          validator: validator,
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
                          hintText: 'Phone Number',
                          textInputType: TextInputType.phone,
                          onChanged: (value) {
                            phoneNumber = value;
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
                        registerButton,
                        SizedBox(
                          height: 10.0,
                        ),
                        cancelButton,
                        SizedBox(
                          height: 10.0,
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
