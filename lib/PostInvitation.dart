// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

// class PostInvitation extends StatefulWidget {
//   const PostInvitation({super.key});

//   @override
//   State<PostInvitation> createState() => _PostInvitationState();
// }

// class _PostInvitationState extends State<PostInvitation> {

//   late ImagePicker _imagePicker;
//   late XFile? _imageFile;

//   @override
//   void initState() {
//     super.initState();
//     _imagePicker = ImagePicker();
//   }

// Future<void> _getImage() async {
//     XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _imageFile = image;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Post Invitation'),
//       ),
//       body:Center(
//         child:Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//              _imageFile == null
//                 ? Text('No Image Selected')
//                 : Image.file(File(_imageFile!.path)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getImage,
//               child: Text('Pick Image'),
//             ),
//           ],
//         ),       
//         ),
//     );
//   }
// }