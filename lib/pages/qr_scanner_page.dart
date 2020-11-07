import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:students/models/attendance.dart';
import 'package:students/models/class.dart';
import 'package:students/models/student_user.dart';

class QrScannerPage extends StatefulWidget {
  final StudentUser studentUser;

  const QrScannerPage({Key key, this.studentUser}) : super(key: key);
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
  }
  // 15 minute in release
  int lateMinutes = 1150000;
  // 50 in release
  double distanceRange = 50000000;
  Class classModel;
  bool isScanned = false;
  String message = 'Dont Forget scanning the code to verify your attendacne';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: _scan,
                child: Text('Open Camera To Scan'),
              ),
              SizedBox(
                height: 100,
              ),
              isScanned
                  ? Card(
                      color: Colors.green,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Attendacnce verified',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Icon(
                              Icons.check,
                              size: 50,
                              color: Colors.white,
                            ),
                            Text(
                              classModel.name,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(message),
            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    this._outputController.text = barcode;
    scanCheck(
        'u%!code@KhFsF7Ni3yM78aaM5K2A@BJ@2020-11-07 03:39:00@33.5026435,36.3159059');
  }

  Future<bool> timeAndLocationCheck(String time, String location) async {
    bool isInTime = false;
    bool isAtLocation = false;
    isAtLocation = await locationCheck(location);
    isInTime = timeCheck(time);
    if (isAtLocation && isInTime)
      return true;
    else
      return false;
  }

  Future<bool> locationCheck(String location) async {
    List<String> locationSplit = location.split(',');
    double endLatitude = double.parse(locationSplit[0]);
    double endLongitude = double.parse(locationSplit[1]);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, endLatitude, endLongitude);

    if (distance < distanceRange) return true;
    return false;
  }

  bool timeCheck(String time) {
    var now = DateTime.now();
    if (now.isBefore(DateTime.parse(time).add(Duration(minutes: lateMinutes))))
      return true;
    return false;
  }

  Future<bool> addAttendance(String attendacneID, classID) async {
    // find class
    Class classModel;
    for (Class c in widget.studentUser.classesList) {
      if (c.id == classID) {
        classModel = c;
        break;
      }
    }
    if (classModel == null) return false;
    // find attendance
    Attendance attendance;
    for (Attendance a in classModel.attendaceList) {
      if (a.id == attendacneID) {
        attendance = a;
        break;
      }
    }
    if (attendance == null) return false;
    this.classModel = classModel;
    if (!attendance.studentsList.contains(widget.studentUser.firebaseID)) {
      attendance.studentsList.add(widget.studentUser.firebaseID);
      final userRef = FirebaseFirestore.instance.collection('attendance');
      await userRef.doc(attendacneID).update({
        "studentsArray": attendance.studentsList,
      });
    }
    return true;
  }

  Future<void> scanCheck(String code) async {
    List<String> splitCode = code.split('@');
    if (splitCode.length == 5 && splitCode[0] == 'u%!code') {
      String attendanceId = splitCode[1];
      String classId = splitCode[2];
      String time = splitCode[3];
      String location = splitCode[4];
      if (await timeAndLocationCheck(time, location)) {
        if (await addAttendance(attendanceId, classId)) {
          setState(() {
            isScanned = true;
          });
        } else {
           setState(() {
          message =
              'This class is not on your classes list';
        });
        }
      } else {
        setState(() {
          message =
              'Sorry you are too late or too far from the QR code location';
        });
      }
    } else {
      setState(() {
        message = 'Not University QR code please Scan Another QR Code';
      });
    }
  }
}