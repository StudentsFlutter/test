import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:students/teachers.dart';


class Teaxhers_Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),


    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Scholar', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final NumerField  =TextField(
      obscureText: false ,
      style: style,
      decoration: InputDecoration (
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText:'ID number',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),);

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),);
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.blue[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0,20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Teachers()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),);
    final RigesterButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.blue[300],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0,20.0, 15.0),
        onPressed: () {},
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),);

    return Scaffold(

      body: Center(
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
                  child: Text('QR attendance ',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w300,
                        fontSize: 35),
                  ),
                ),
                Container (
                  child: Image.asset("assets/images/logo.Jpg",), height: 250 ,width: 200, alignment: Alignment.center,
                ),
                NumerField ,SizedBox (height: 25.0),
                passwordField, SizedBox(height: 35.0,),
                loginButon, SizedBox(height: 15.0,),
                RigesterButon,SizedBox(height: 15.0,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
