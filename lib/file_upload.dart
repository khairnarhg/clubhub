import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

Future<void> uploadFile(String clubName, String folderName) async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.any);

  if (result != null) {
    PlatformFile file = result.files.first;

    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref('$clubName/$folderName/${file.name}');

      // Upload the file to Firebase Storage
      await storageReference.putData(file.bytes!);

      print('Uploaded ${file.name} successfully');
    } catch (e) {
      print('Failed to upload ${file.name}. Error: $e');
    }
  } else {
    print('No file selected');
  }
}
