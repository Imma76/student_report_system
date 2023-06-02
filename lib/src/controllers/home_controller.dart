import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_system/main.dart';
import 'package:report_system/src/controllers/home_controller.dart';
import 'package:report_system/src/controllers/image_controller.dart';
import 'package:report_system/src/models/report.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../collections/collections.dart';
import '../models/user.dart';
import '../servicees/report_service.dart';
import '../servicees/user_service.dart';
import '../utils/colors.dart';
import '../utils/dialogue_function.dart';
import '../utils/report_status.dart';


class HomeController extends ChangeNotifier {
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
    return Collections.reportCollection.where("userId",isEqualTo: centralState.user!.uid).snapshots();
  }

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
      report: abuseExplanationController.text.trim(),
      isAnonymous: isAnonymous,
      email: userModel?.email,
      createdAt: DateTime.now(),
      userId: centralState.user!.uid,
      reportStatus: ReportStatus.submitted,
    );
    bool submit = await reportService.createReport(reportModel);
    load = false;

    imageController.clearList();
    clearTextController();
    notifyListeners();
    Navigator.pop(navigatorKey!.currentContext!);

    Alert(context: navigatorKey!.currentContext!, title: "",image: Icon(Icons.check), desc: "Report has been submitted", buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(navigatorKey!.currentContext!),
        color: primaryColor,
      ),]).show();
  }

}