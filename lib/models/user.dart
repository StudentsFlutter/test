import 'package:cloud_firestore/cloud_firestore.dart';

class UserM {
  String id;
  String name;
  String email;
  String phoneNumber;
  String level;

  UserM({this.id, this.name, this.email, this.phoneNumber, this.level});

  factory UserM.fromDocument(DocumentSnapshot doc) {
    return UserM(
        name: doc['Name'],
        id: doc['UserId'],
        email: doc['Name'],
        level: doc['Level'],
        phoneNumber: doc['PhoneNumber']);
  }
}
