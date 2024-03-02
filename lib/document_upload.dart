import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class DocumentUpload extends StatefulWidget {
  final String clubId;
  const DocumentUpload({super.key, required this.clubId});

  @override
  _DocumentUploadState createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {
  File? document;
  String? documentName;

  Future pickDocument() async {
    FilePickerResult? pickedDocument =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (pickedDocument != null) {
      setState(() {
        document = File(pickedDocument.files.single.path!);
        documentName = path.basename(pickedDocument.files.single.name);
      });
    }
  }

  Future uploadDocument() async {
    if (document != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${widget.clubId}/')
          .child(documentName!);

      await storageRef.putFile(document!);
      // Handle successful upload (e.g., show a success message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Upload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (document != null)
              Container(
                width: 200,
                height: 200,
                child: Center(child: Text('Preview: $documentName')),
              ),
            ElevatedButton(
              onPressed: pickDocument,
              child: const Text('Pick Document'),
            ),
            ElevatedButton(
              onPressed: uploadDocument,
              child: const Text('Upload Document'),
            ),
          ],
        ),
      ),
    );
  }
}
