import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'file_upload.dart';

class UploadMeetingDocs extends StatefulWidget {
  final String clubId;
  const UploadMeetingDocs({super.key, required this.clubId});

  @override
  _UploadMeetingDocsState createState() => _UploadMeetingDocsState();
}

class _UploadMeetingDocsState extends State<UploadMeetingDocs> {
  @override
  void initState() {
    super.initState();
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("File selected");
    } else {
      print('No file selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Meeting Docs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickFile,
              child: const Text('Pick File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => uploadFile(widget.clubId, 'meeting_docs'),
              child: const Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
