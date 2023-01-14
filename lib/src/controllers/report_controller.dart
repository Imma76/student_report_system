import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_system/src/controllers/home_controller.dart';
import 'package:report_system/src/controllers/image_controller.dart';
import 'package:report_system/src/models/report.dart';

import '../servicees/report_service.dart';


class ReportController extends ChangeNotifier {

  bool isAnonymous = true;
  TextEditingController abuseExplanationController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currentLevelController = TextEditingController();
  ReportService reportService = ReportService();
  List<String> audioUrls = [];
  List<String> imageUrls = [];
  List<String> videoUrls = [];
  bool load = false;



  changeReportVisibility(bool newValue){
    isAnonymous = newValue;
    notifyListeners();
  }

  bool validateMedia(ImageController imageController){
    if(imageController.imageFiles.isEmpty && imageController.videoFiles.isEmpty && imageController.audioFiles.isEmpty){
      return false;
    }
    return true;
  }
  clearTextController(){
    nameController.clear();
    regNoController.clear();
    abuseExplanationController.clear();

  }


  Future submitReport(ImageController imageController)async{
    load = true;
    notifyListeners();

    await imageController.uploadAudio();
    await imageController.uploadImage();
    await imageController.uploadVideo();
    Reports reportModel = Reports(
      audioUrls:imageController.audioUrlList,
      imageUrls: imageController.imageUrlList,
      videoUrls: imageController.videoUrlList,
      name:nameController.text,
      regNo: regNoController.text,
      report: abuseExplanationController.text,
      isAnonymous: isAnonymous,
      email: homeController.userModel?.email,
    );
    bool submit = await reportService.createReport(reportModel);
    load = false;

    imageController.clearList();
    clearTextController();
    notifyListeners();
  }

}