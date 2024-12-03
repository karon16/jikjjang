import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class HelperFunctions {
  Future<String> uploadImage(File imageFile, String uri) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('$uri/${DateTime.now().millisecondsSinceEpoch}');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }
}
