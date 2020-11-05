import 'package:students/models/attendance.dart';

class Class{
String name;
 String id;
List<Attendace> attendaceList = []; // store only id of attendace on firebase
Class({this.name,this.id});
}