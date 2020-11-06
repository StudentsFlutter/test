
class Attendace {
  String id;
  List<String> studentsList = []; // store only user id on firebase
  String date; // could be another data type
  //  Teacher teacher //maybe add teacher id   
  Attendace ({this.date,this.studentsList});

}