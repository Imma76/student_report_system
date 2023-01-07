import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../servicees/image_service.dart';

class ImageController extends ChangeNotifier{

  List<File> audioFiles = [];
  List<File> imageFiles= List<File>.empty(growable: true);
  List<File> videoFiles = [];
  final _picker = ImagePicker();

  void pickImage ()async{

    try {
      print('ksjshdhgd');
      final pickedImageFiles = await _picker.pickMultiImage(
        // source: ImageSource.gallery,
      );



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
  void uploadImage()async{
    List<String> urlList = [];
    if(imageFiles.isNotEmpty){
      for(var imageFile in imageFiles){
        String url  = await ImageService.storeImage(imageFile, File(imageFile.));
      }
    }
  }
}


ImageController imageController = ImageController();