import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:students/widgets/input_text_field.dart';


import 'Register_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Scholar', fontSize: 20.0);
 final formKey = GlobalKey<FormState>();
  String password;
  String email;
  Future login() async {
      if (!formKey.currentState.validate()) return;
    setState(() {
      isLogin = true;
    });


    //if login 
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DashBoard(),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
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
