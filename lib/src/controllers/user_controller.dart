import 'package:flutter/material.dart';
import 'package:report_system/src/servicees/user_service.dart';

import '../models/user.dart';

class UserController extends ChangeNotifier{
  final userService=UserService();

  Future createUser(UserModel userModel)async{
    final response = await userService.createUser(userModel);
    return response;
  }
}