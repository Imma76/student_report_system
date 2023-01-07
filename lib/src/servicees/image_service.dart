import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageService{

  static Future<String> storeImage(File image, String name)async{

    final upload = await FirebaseStorage.instance.ref('images/').child(name).putFile(image);

    final url = await FirebaseStorage.instance.ref('images/').child(name).getDownloadURL();
    return url;
  }
}