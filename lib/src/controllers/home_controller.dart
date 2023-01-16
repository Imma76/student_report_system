import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:report_system/src/collections/collections.dart';
import 'package:report_system/src/models/user.dart';
import 'package:report_system/src/servicees/user_service.dart';

class HomeController extends ChangeNotifier{
  UserService userService = UserService();
  UserModel? userModel;


  void initializeHome()async{
    final response = await  userService.getCurrentUser();
    if(response != null){
      userModel = response;
      notifyListeners();
    }

  }
  Stream<QuerySnapshot> reportStream(){
    return Collections.reportCollection.snapshots();
  }

}

final homeController = HomeController();