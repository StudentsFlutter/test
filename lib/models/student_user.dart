import 'package:cloud_firestore/cloud_firestore.dart';

class StudentUser {
  String id;
  String name;
  String email;
  String phoneNumber;
  String level;

  StudentUser({this.id, this.name, this.email, this.phoneNumber, this.level});

  factory StudentUser.fromDocument(DocumentSnapshot doc) {
    return StudentUser(
        name: doc['Name'],
        id: doc['UserId'],
        email: doc['Email'],
        level: doc['Level'],
        phoneNumber: doc['PhoneNumber']);
  }
}
