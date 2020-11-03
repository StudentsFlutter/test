import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:students/models/student_user.dart';
import 'package:students/pages/dashbord_page.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

const password = '********';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  _EditProfilePageState();

  StudentUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRef = Firestore.instance.collection('users');
  Future<StudentUser> fetch_user_firestore() async {
    final snapshot = _auth.currentUser;

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    DocumentSnapshot doc = await userRef.document(snapshot.uid).get();
    StudentUser userM = StudentUser.fromDocument(doc);
    return userM;
  }

  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      user = await fetch_user_firestore();
      setState(() {
        isLoading = false;
      });
    } catch (ex) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/female-profile.png'),
                    ),
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 200,
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    InfoCard(
                      text: user.id,
                      icon: Icons.web,
                    ),
                    InfoCard(
                      text: user.email,
                      icon: Icons.email,
                      onPressed: () async {
                        final emailAddress = 'mailto:${user.email}';

                        if (await launcher.canLaunch(emailAddress)) {
                          await launcher.launch(emailAddress);
                        } else {
                          _showDialog(
                            context,
                            title: 'Sorry',
                            msg: 'Email can not be send. Please try again!',
                          );
                        }
                      },
                    ),
                    InfoCard(
                      text: user.phoneNumber,
                      icon: Icons.phone,
                    ),
                    InfoCard(
                      text: 'Student',
                      icon: Icons.web,
                    ),
                    InfoCard(
                        text: password,
                        icon: Icons.card_membership,
                        onPressed: () async {
                          // String removeSpaceFromPhoneNumber =
                          //     phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
                          // final password = 'password';
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard()),
                            );
                          },
                          child: Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.1,
                                  color: Colors.black)),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.teal[200],
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.1,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  InfoCard({
    @required this.text,
    @required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 10.0,
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}
