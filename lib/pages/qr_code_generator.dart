import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class QrCodeGeneratorPage extends StatefulWidget {
  @override
  _QrCodeGeneratorPageState createState() => _QrCodeGeneratorPageState();
}

class _QrCodeGeneratorPageState extends State<QrCodeGeneratorPage> {
  Uint8List bytes = Uint8List(0);
    Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR code Generator'),),
      body: Column(
          children: [


          ],
        
      ),
    );
  }
}