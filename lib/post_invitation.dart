import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/dashboard_student.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostInvitation extends StatefulWidget {
  final String clubId;
  const PostInvitation({super.key, required this.clubId});
  @override
  State<PostInvitation> createState() => _PostInvitationState();
}

class _PostInvitationState extends State<PostInvitation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String imageUrl = '';
  final TextEditingController _caption = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   _caption = TextEditingController();
  // }
  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  XFile? images;
  Future getImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    print('${image?.path}');
    if (image == null) return;
    XFile imageTemp = image;

    setState(() {
      images = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Invitation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Center(
              child: Text(
                'Pick an Image',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            images != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(File(images!.path),
                        width: 300, height: 300, fit: BoxFit.cover))
                : Image.asset('assets/images/uploadphoto.png',
                    width: 300, height: 300),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: const Text('Pick from gallery'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.camera),
              child: const Text('Click a photo'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  if (images == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select an image')));
                  }
                  String uniquefilename =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('posts');

                  Reference referenceImageatoUpload =
                      referenceDirImages.child(uniquefilename);
                  try {
                    await referenceImageatoUpload.putFile(
                      File(images!.path),
                      SettableMetadata(contentType: 'image/jpeg'),
                    );
                    imageUrl = await referenceImageatoUpload.getDownloadURL();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Image uploaded')));
                    print(imageUrl);
                  } catch (error) {
                    print('error uploading file');
                  }
                },
                child: const Text('upload')),
            const SizedBox(height: 50),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _caption,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Enter the caption',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is mandatory';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String capt = _caption.text;

                  DocumentReference<Map<String, dynamic>> documentref =
                      FirebaseFirestore.instance
                          .collection('clubs')
                          .doc(widget.clubId);
                  DocumentSnapshot<Map<String, dynamic>> docsnapshot =
                      await documentref.get();
                  String clubName = docsnapshot.data()?['Club_Name'];
                  Map<String, String> datatosend = {
                    'clubName': clubName,
                    'caption': capt,
                    'image': imageUrl,
                  };
                  FirebaseFirestore.instance
                      .collection('clubs')
                      .doc(widget.clubId)
                      .collection('Events')
                      .doc('220101')
                      .collection('Invitations')
                      .add(datatosend);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Posted')));
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardStudent()));
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
