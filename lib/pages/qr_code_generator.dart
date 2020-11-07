import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:students/models/class.dart';

class QrCodeGeneratorPage extends StatefulWidget {
  @override
  _QrCodeGeneratorPageState createState() => _QrCodeGeneratorPageState();
}

class _QrCodeGeneratorPageState extends State<QrCodeGeneratorPage> {
  bool isLoading = false;
  getClassesList() async {
    setState(() {
      isLoading = true;
    });
    List<Class> classNames = [];
    final classesRef = FirebaseFirestore.instance.collection('classes');
    QuerySnapshot allNames = await classesRef.getDocuments();
    for (int i = 0; i < allNames.docs.length; i++) {
      var a = allNames.docs[i];

      classNames.add(Class(name: a['ClassName'], id: a.id));
    }
    classesList = classNames;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getClassesList();
    super.initState();
  }

  List<Class> classesList = [
    Class(name: 'hi', id: 'kkgkgk'),
  ];
  Class currentClass;
  Uint8List bytes = Uint8List(0);
  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code Generator'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _qrCodeWidget(bytes, context),
                DropdownButton(
                  hint: Text('السنة'),
                  value: currentClass,
                  onChanged: (newValue) {
                    setState(() {
                      currentClass = newValue;
                    });
                  },
                  items: classesList.map((c) {
                    return DropdownMenuItem(
                      child: new Text(c.name),
                      value: c.id,
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Text('  Generate Qrcode', style: TextStyle(fontSize: 15)),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? Center(
                            child: Text('Empty code ... ',
                                style: TextStyle(color: Colors.black38)),
                          )
                        : Image.memory(bytes),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              'remove',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () =>
                                this.setState(() => this.bytes = Uint8List(0)),
                          ),
                        ),
                        Text('|',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black26)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final success =
                                  await ImageGallerySaver.saveImage(this.bytes);
                              SnackBar snackBar;
                              if (success != null) {
                                snackBar = new SnackBar(
                                    content:
                                        new Text('Successful Preservation!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = new SnackBar(
                                    content: new Text('Save failed!'));
                              }
                            },
                            child: Text(
                              'save',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}
