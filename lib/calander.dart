
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Calendar',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Future getData() async{
    //var url ="http://10.0.2.2:8080/GP/index.php";
    var response =  await http.get("http://127.0.0.1/GP/index.php") ;
    var responsebody = jsonDecode(response.body);
    return responsebody ;
  }


  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        title: Text("Academic Calendar"),
        centerTitle: true,
      ),
      body:FutureBuilder(
      //  future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context ,i){
              return calanderdb(gregorianData:snapshot.data[i]['gregorianData'],HijriData:snapshot.data[i]['HijriData'] ,day:snapshot.data[i]['day']
                  ,week:snapshot.data[i]['week'] ,procedure:snapshot.data[i]['procedure']);
            },

          ) ;
          }
         return Center(child: CircularProgressIndicator()) ;
        },

      ),

    ));// end return Directionality and Scaffold
  }

}


class calanderdb extends StatelessWidget{
 final procedure ;
  final week ;
  final day ;
  final HijriData;
  final gregorianData;

  calanderdb({this.gregorianData ,this.HijriData ,this.day ,this.week ,this.procedure});


 @override
  Widget build(BuildContext context) {

    return Container(
      height: 140,
      width: 140,
      child: Card(
        child: Column(children: [
          Expanded(child: Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 10), alignment:Alignment.topCenter, height:100,decoration: BoxDecoration(border: Border.all(color: Colors.black26)),child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(procedure , style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold,fontSize: 17) ),
              Row(

                children: [
                  Expanded(child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(" اليوم : ", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)))),
                  Expanded(child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(day, style: TextStyle(color: Colors.black)))),
                  Expanded (child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(" الاسبوع : ", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)))),
                  Expanded(child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(week, style: TextStyle(color: Colors.black))))

                ],),

              Row(

                children: [
                  Expanded(child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(" التاريخ الهجري : ", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)))),
                  Expanded(child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(HijriData, style: TextStyle(color: Colors.black)))),
                  Expanded (child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(" التاريخ الميلادي : ", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)))),
                  Expanded(child: Container( padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      child: Text(gregorianData, style: TextStyle(color: Colors.black))))

                ],),


            ],),) )


        ],),
      ),); //container for list-view
  }


}

