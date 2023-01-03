import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';


class ReportController extends ChangeNotifier{
  bool isAnonymous = true;
  final _picker = ImagePicker();
  changeReportVisibility(bool newValue){
    isAnonymous = newValue;
    notifyListeners();
  }
  List<File> audioFiles = [];
  List<File> imageFiles= List<File>.empty(growable: true);
  List<File> videoFiles = [];

  void pickImage ()async{
    // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.image);
    //
    // if (result != null) {
    //   imageFiles = result.paths.map((path) => File(path.toString())).toList();
    //   notifyListeners();
    // } else {
    //   // User canceled the picker
    // }
    try {
      print('ksjshdhgd');
      final pickedImageFiles = await _picker.pickMultiImage(
        // source: ImageSource.gallery,
      );
      // FilePickerResult? result = await FilePicker.platform.pickFiles(
      //   allowMultiple: true,
      //   allowedExtensions: ['jpg', 'mp4', 'mkv', ''],
      // );


      if (pickedImageFiles!.isNotEmpty) {
        for (XFile image in pickedImageFiles) {
          imageFiles.add(File(image.path));
          notifyListeners();
        }
       // return ourImages;
      } else {
        print('selected image is null');
       // return ourImages;
      }
    } catch (e) {
      print('hhhh$e');

    }
  }
  void pickVideos ()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.video);

    if (result != null) {
      videoFiles = result.paths.map((path) => File(path.toString())).toList();
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }
  void pickAudios ()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.audio);

    if (result != null) {
      audioFiles = result.paths.map((path) => File(path.toString())).toList();
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }
}