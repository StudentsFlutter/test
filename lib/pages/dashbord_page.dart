import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:students/pages/personal_info_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    DashboardCard(
                      text: 'Personal info.',
                      imagePath: 'assets/images/personal_information.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                      },
                    ),
                    DashboardCard(
                      text: 'QR code Scanner',
                      imagePath: 'assets/images/qrcode.reader.png',
                      onPressed: () {
                        print('QR');
                      },
                    ),
                    DashboardCard(
                      text: 'Attendance',
                      imagePath: 'assets/images/att.png',
                      onPressed: () {
                        print('Att');
                      },
                    ),
                    DashboardCard(
                      text: 'weekly Schedule',
                      imagePath: 'assets/images/attendance.png',
                      onPressed: () {
                        print('weekly Schedule');
                      },
                    ),
                    DashboardCard(
                      text: 'Academic Calender',
                      imagePath: 'assets/images/weekly_schedual.png',
                      onPressed: () {
                        print('Academic Calender');
                      },
                    ),
                    DashboardCard(
                      text: 'technical Support',
                      imagePath: 'assets/images/support.png',
                      onPressed: () {
                        customLaunch(
                            'mailto:graduation.7wk@gmail.com ?subject=test%20subject&body=test%20body');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final Function onPressed;
  const DashboardCard({
    Key key,
    this.text,
    this.imagePath,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CircleBorder(),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            child: MaterialButton(
              onPressed: onPressed,
              child: Image.asset(
                imagePath,
                height: 85,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
                fontFamily: "Montserrat Regular",
                fontSize: 14,
                color: Color.fromRGBO(63, 63, 63, 1)),
          ),
        ],
      ),
    );
  }
}
