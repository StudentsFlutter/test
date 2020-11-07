import 'package:flutter/material.dart';
import 'package:students/models/attendance.dart';
import 'package:students/models/class.dart';
import 'package:students/models/student_user.dart';

class AttendancePage extends StatefulWidget {
  final StudentUser studentUser;

  const AttendancePage({Key key, this.studentUser}) : super(key: key);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Attendace List'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.studentUser.classesList.length,
            itemBuilder: (BuildContext context, int index) {
              return AttendanceListTile(
                classModel: widget.studentUser.classesList[index],
                studentUser: widget.studentUser,
              );
            },
          ),
        ));
  }
}

class AttendanceListTile extends StatefulWidget {
  final Class classModel;
  final StudentUser studentUser;
  const AttendanceListTile({Key key, this.classModel, this.studentUser})
      : super(key: key);
  @override
  _AttendanceListTileState createState() => _AttendanceListTileState();
}

class _AttendanceListTileState extends State<AttendanceListTile> {
  @override
  Widget build(BuildContext context) {
   if(widget.classModel.attendaceList==null) print('object');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.classModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.classModel.attendaceList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AttendanceCard(
                    classModel: widget.classModel,
                    isAttended: widget
                        .classModel.attendaceList[index].studentsList
                        .contains(
                      widget.studentUser.firebaseID,
                    ),
                    attendace: widget.classModel.attendaceList[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final Class classModel;
  final Attendance attendace;
  final bool isAttended;

  const AttendanceCard(
      {Key key, this.classModel, this.attendace, this.isAttended})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        color: isAttended ? Colors.green : Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(isAttended ? 'Attended' : 'Not Attended'),
            Text(attendace.date),
          ],
        ),
      ),
    );
  }
}
