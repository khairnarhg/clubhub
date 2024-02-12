import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/dashboard_student.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostInvitation extends StatefulWidget {
  const PostInvitation({super.key});

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
      this.images = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Invitation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'Pick an Image',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            images != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(File(images!.path),
                        width: 300, height: 300, fit: BoxFit.cover))
                : Image.asset('assets/images/uploadphoto.png',
                    width: 300, height: 300),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: Text('Pick from gallery'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.camera),
              child: Text('Click a photo'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  if (images == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select an image')));
                  }
                  ;
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
                        SnackBar(content: Text('Image uploaded')));

                    

                    print(imageUrl);
                  } catch (error) {
                    print('error uploading file');
                  }
                },
                child: Text('upload')),
            SizedBox(height: 50),
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
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String capt = _caption.text;
                  Map<String, String> datatosend = {
                    'caption': capt,
                    'image': imageUrl,
                  };
                  FirebaseFirestore.instance
                      .collection('Invitations')
                      .add(datatosend);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Posted')));
                }

                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard()));
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
