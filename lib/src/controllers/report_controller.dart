import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_system/src/controllers/image_controller.dart';
import 'package:report_system/src/models/report.dart';

import '../servicees/report_service.dart';


class ReportController extends ChangeNotifier{
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
    await imageController.uploadAudio();
    await imageController.uploadImage();
    await imageController.uploadVideo();
    Reports reportModel = Reports(audioUrls:imageController.audioUrlList, imageUrls: imageController.imageUrlList, videoUrls: imageController.videoUrlList,  );
    bool submit = await reportService.createReport(reportModel);
  }

}