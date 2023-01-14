import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_system/main.dart';
import 'package:report_system/src/collections/collections.dart';

import '../models/user.dart';

class UserService{

  Future<bool> createUser(UserModel userModel) async{
    try{
      final response = await Collections.userCollection.doc(userModel.userId).set(userModel.toJson());
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<bool> checkIfUserExists(String number)async{
    try{
      final response = await Collections.userCollection.where("mobile",isEqualTo: number).get();
      if(response.docs.isNotEmpty){
        return true;
      }
      return false;
    }catch(e){
      print(e.toString());
      return false;
    }

  }
  Future getCurrentUser()async{
    try{
      final response= await Collections.userCollection.where("mobile",isEqualTo: centralState.user!.phoneNumber).get();
      if(response.docs.isNotEmpty){
        centralState.userData( UserModel.fromJson(response.docs as Map<String,dynamic>));
        return UserModel.fromJson(response.docs as Map<String,dynamic>);

      }
      return null;
    }catch(e){
      return null;
      print(e.toString());
    }
  }
}