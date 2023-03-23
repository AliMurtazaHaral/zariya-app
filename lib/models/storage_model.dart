import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class StorageModel {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadFileImage(String? path, String? fileN) async {
    String? filePath = path;
    String? fileName = fileN;
    File file = File(filePath!);
    try {
      await storage.ref('campaignDocs/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
  Future<void> uploadFileImageCampaign(String? path, String? fileN) async {
    String? filePath = path;
    String? fileName = fileN;
    File file = File(filePath!);
    try {
      await storage.ref('campaignImage/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
  Future<void> uploadProfileImage(String? path, String? fileN) async {
    String? filePath = path;
    String? fileName = fileN;
    File file = File(filePath!);
    try {
      await storage.ref('profileImage/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
