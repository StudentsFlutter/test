import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students/models/class.dart';
import 'package:students/models/student_user.dart';

class SelectClassesPage extends StatefulWidget {
  final StudentUser studentUser;

  const SelectClassesPage({Key key, @required this.studentUser})
      : super(key: key);
  @override
  _SelectClassesPageState createState() => _SelectClassesPageState();
}

class _SelectClassesPageState extends State<SelectClassesPage> {
  Future<List<Class>> getClassesName() async {
    List<Class> classNames = [];
    final classesRef = FirebaseFirestore.instance.collection('classes');
    QuerySnapshot allNames = await classesRef.get();
    for (int i = 0; i < allNames.docs.length; i++) {
      var a = allNames.docs[i];

      classNames.add(Class(name: a['ClassName'], id: a.id));
    }
    return classNames;
  }

  List<Class> classesList;
  List<bool> isPreList = [];
  List<Class> getCheckedClasses() {
    List<Class> checkedClassesList = [];
    for (int i = 0; i < isPreList.length; i++) {
      if (isPreList[i]) {
        checkedClassesList.add(classesList[i]);
      }
    }
    return checkedClassesList;
  }

  Future<void> setLists() async {
    setState(() {
      isLoading = true;
    });

    classesList = await getClassesName();
    for (Class c in classesList) {
      bool b = false;
      for (Class studentClass in widget.studentUser.classesList) {
        if (c.id == studentClass.id) {
          isPreList.add(true);
          b = true;
          break;
        }
      }
      if (!b) isPreList.add(false);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    setLists();
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes Selection'),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Select Your Classes',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    height: MediaQuery.of(context).size.height * .65,
                    width: MediaQuery.of(context).size.width * .8,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: classesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ClassListTile(
                            classModel: classesList[index],
                            isPreChecked: isPreList[index],
                            onChange: (value) {
                              setState(() {
                                isPreList[index] = value;
                              });
                            },
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            widget.studentUser.classesList =
                                getCheckedClasses();
                            final userRef =
                                Firestore.instance.collection('users');
                            final FirebaseAuth _auth = FirebaseAuth.instance;
                            final snapshot = await _auth.currentUser;
                            List<String> idsArray = [];
                            for (Class c in widget.studentUser.classesList) {
                              idsArray.add(c.id);
                            }
                            await userRef.document(snapshot.uid).update({
                              "classesIds": idsArray,
                            });
                            // save to firebase
                            Navigator.pop(context);
                          },
                          child: Text('Save'),
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class ClassListTile extends StatefulWidget {
  final Class classModel;
  final bool isPreChecked;
  final Function onChange;
  const ClassListTile(
      {Key key, this.classModel, this.isPreChecked, this.onChange})
      : super(key: key);
  @override
  _ClassListTileState createState() => _ClassListTileState();
}

class _ClassListTileState extends State<ClassListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.classModel.name),
          Checkbox(
            value: widget.isPreChecked,
            onChanged: widget.onChange,
          )
        ],
      ),
    );
  }
}
