import 'package:cloud_firestore/cloud_firestore.dart';


final _firebase = FirebaseFirestore.instance;
class Collections{

  CollectionReference reportCollection = _firebase.collection("reports");
  CollectionReference userCollection = _firebase.collection("users");

}