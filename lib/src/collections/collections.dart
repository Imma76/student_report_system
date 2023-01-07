import 'package:cloud_firestore/cloud_firestore.dart';


final _firebase = FirebaseFirestore.instance;
class Collections{

  static CollectionReference reportCollection = _firebase.collection("reports");
  static CollectionReference userCollection = _firebase.collection("users");

}