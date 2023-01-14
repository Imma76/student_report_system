import 'package:flutter/foundation.dart';
import 'package:report_system/src/models/user.dart';
import 'package:report_system/src/servicees/user_service.dart';

class HomeController extends ChangeNotifier{
  UserService userService = UserService();
  UserModel? userModel;
  void initializeApp()async{
    final response =await  userService.getCurrentUser();
    if(response != null){
      userModel = response;
      notifyListeners();
    }
  }

}

final homeController = HomeController();