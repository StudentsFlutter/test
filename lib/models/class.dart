import 'package:students/models/attendance.dart';

class Class{
String name;
 String id;
List<Attendance> attendaceList = []; // store only id of attendace on firebase
Class({this.name,this.id,this.attendaceList});
}