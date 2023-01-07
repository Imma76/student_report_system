import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_system/src/collections/collections.dart';

class UserService{
  final collection =  Collections();
  Future createUser() async{
    final response = await collection.userCollection.add();
  }
}