import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_system/src/controllers/image_controller.dart';


class ReportController extends ChangeNotifier{
  bool isAnonymous = true;
  TextEditingController abuseExplanationController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currentLevelController = TextEditingController();

  changeReportVisibility(bool newValue){
    isAnonymous = newValue;
    notifyListeners();
  }

  bool validateMedia(){
    if(imageController.imageFiles.isEmpty && imageController.videoFiles.isEmpty && imageController.audioFiles.isEmpty){
      return false;
    }
    return true;
  }


  Future submitReport()async{
    
  }

}