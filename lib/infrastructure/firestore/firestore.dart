import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  Firestore._();

  static DocumentReference<Map<String, dynamic>> get version =>
      FirebaseFirestore.instance.collection('version').doc("v1");

  static CollectionReference<Map<String, dynamic>> get users =>
      version.collection("users");

  static DocumentReference<Map<String, dynamic>> get config =>
      version.collection("config").doc("info");

  static CollectionReference<Map<String, dynamic>> get news =>
      version.collection("news");
}
