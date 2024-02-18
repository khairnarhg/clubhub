import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FirebaseStorageService {
  FirebaseStorageService({required this.clubId, required this.context});

  final String clubId;
  final BuildContext context;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String subfolder) async {
    File file = File(filePath);
    try {
      await storage
          .ref('$clubId/$subfolder/${file.path.split('/').last}')
          .putFile(file);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully!')),
      );
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File upload failed: ${e.message}')),
      );
    }
  }
}
