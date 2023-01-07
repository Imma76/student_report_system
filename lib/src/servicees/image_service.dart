import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
class ImageService{




  static Future<String> storeImage(File image, )async{
    final name = uuid.v4();

    final upload = await FirebaseStorage.instance.ref('images/').child(name).putFile(image);

    final url = await FirebaseStorage.instance.ref('images/').child(name).getDownloadURL();
    return url;
  }
}