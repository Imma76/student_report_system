import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_system/src/collections/collections.dart';

import '../models/user.dart';

class UserService{
  final collection =  Collections();
  Future<bool> createUser(UserModel userModel) async{
    try{
      final response = await collection.userCollection.add(userModel.toJson());
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }


  }
}