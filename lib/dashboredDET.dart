// import 'package:flutter/material.dart';

// class dashboredET extends StatefulWidget {
//   final ID_d ;
//   final Name_d ;


//   dashboredET({this.ID_d,this.Name_d,});

//   @override
//   dashboredET_State dashboredETState() => dashboredET_State();
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

// class dashboredET_State extends State<dashboredET> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('pirsanal information '),
//           centerTitle: true ,
//         ),
//         body: ListView(
//           children: <Widget>[
//           /*  Container(
//               height:300,
//               child: Image.asset('assets/images/female-profile.png' ),
//               footer:Container(
//                 color: Colors.black,
//                 child :Directionality(
//                    textDirection: TextDirection.ltr,
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(child: Container(
//                         padding: EdgeInsets.all(10),
//                        child: Text(
//                          "${widget.ID_d}\$",
//                          style:TextStyle(
//                            color: Colors.white,
//                            fontSize: 20,
//                        ),
//                        ),
//                       )),
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           "${widget.Name_d}\$",
//                           style:TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),*/

//           Container(
//           padding: EdgeInsets.all(10),
//               child: Column(
//                children: <Widget> [
//                  mySpec(context , "ID" , widget.ID_d ,Colors.white,Colors.black),
//                  mySpec(context , "FirstName"  , widget.Name_d ,Colors.white,Colors.black),
//                  Padding(
//                      padding: EdgeInsets.all(10),
//                      child: Text(
//                        "الكاميرات",
//                        style: TextStyle(fontSize: 20),
//                      ),
//                  ),
//                ],
//                  ),
//           ),
//           ],
//         ),
//       ),
//     ) ;
//   }

// }

// mySpec(context, String feature ,String details , Color colorbackground , Color colortext) {
//   return Container(
//        width: MediaQuery.of(context).size.width,
//        padding: EdgeInsets.all(10),
//        color: colorbackground ,
//        child: RichText(
//        text: TextSpan(
//          style:TextStyle( fontSize:19 , color: Colors.black),
//          children: <TextSpan>[
//            TextSpan(text: feature),
//            TextSpan(text: details,
// //             style: TextStyle(color: colortext)
//            ),
//          ]
//        ),
//        ),
//   );
// }

