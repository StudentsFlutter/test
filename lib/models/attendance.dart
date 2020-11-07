
import 'package:flutter/cupertino.dart';

class Attendance {
  String id;
  List<String> studentsList = []; // store only user id on firebase
  String date; // could be another data type
  //  Teacher teacher //maybe add teacher id   
  Attendance ({@required this.id,this.date,this.studentsList});

}