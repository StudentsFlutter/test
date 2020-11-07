import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students/models/class.dart';
import 'package:students/models/student_user.dart';
import 'package:students/models/time_for_class.dart';

class TablePage extends StatefulWidget {
  final StudentUser studentUser;

  const TablePage({Key key, this.studentUser}) : super(key: key);
  @override
  _TablePageState createState() => _TablePageState();
}

Future<List<TimeForClass>> getTimesListForClass(String classId) async {
  List<TimeForClass> timesList = [];

  final timesRef = FirebaseFirestore.instance
      .collection('classes')
      .doc(classId)
      .collection('Times');

  QuerySnapshot allNames = await timesRef.getDocuments();
  for (int i = 0; i < allNames.docs.length; i++) {
    var a = allNames.docs[i];

    timesList.add(TimeForClass.fromDocument(a));
  }

  return timesList;
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Table List'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.studentUser.classesList.length,
            itemBuilder: (BuildContext context, int index) {
              return TableListTile(
                classModel: widget.studentUser.classesList[index],
              );
            },
          ),
        ));
  }
}

class TableListTile extends StatefulWidget {
  final Class classModel;

  const TableListTile({Key key, this.classModel}) : super(key: key);
  @override
  _TableListTileState createState() => _TableListTileState();
}

class _TableListTileState extends State<TableListTile> {
  List<TimeForClass> tfcL = [];
 void init() async {
    final temp = await getTimesListForClass(widget.classModel.id);
    setState(() {
      tfcL = temp;
    });
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tfcL.length,
                itemBuilder: (BuildContext context, int index) {
                  return AttendanceCard(
                    wwww: tfcL[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

String int2Day(int a) {
  switch (a) {
    case 0:
      return "Sat";
      break;
    case 1:
      return "Sun";
      break;
    case 2:
      return "Mon";
      break;
    case 3:
      return "Tue";
      break;
    case 4:
      return "Wen";
      break;
    case 5:
      return "Thi";
      break;
    case 6:
      return "Fri";
      break;
    default:
      return "";
      break;
  }
}

class AttendanceCard extends StatelessWidget {
  final TimeForClass wwww;

  const AttendanceCard({Key key, this.wwww}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(wwww.startTime.toString());
    return Container(
      width: 100,
      height: 100,
      child: Card(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(int2Day(wwww.day)),
            Text(wwww.startTime.format(context)),
            Text(wwww.endTime.format(context)),
          ],
        ),
      ),
    );
  }
}
