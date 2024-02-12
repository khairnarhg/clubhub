import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/dashboard_cc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PermissionRequestForm extends StatefulWidget {
  final String staffmember;
  const PermissionRequestForm({Key? key, required this.staffmember})
      : super(key: key);

  @override
  State<PermissionRequestForm> createState() => _PermissionRequestFormState();
}

class _PermissionRequestFormState extends State<PermissionRequestForm> {
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create PR'),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _subject,
            decoration: InputDecoration(labelText: 'Subject'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _description,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: null,
          ),
          ElevatedButton(
            onPressed: () async {
              String subject = _subject.text;
              String description = _description.text;
              String staffmembernumber = widget.staffmember;

              String? uid = FirebaseAuth.instance.currentUser?.uid;
              String? documentId = await fetchUID(uid!);
              String? ccmemberId = await fetchcollegeid(documentId!);

              permissionRequest request = permissionRequest(
                  staffmemberId: staffmembernumber,
                  subject: subject,
                  description: description,
                  status: 'pending',
                  ccmemberId: ccmemberId.toString());

              await FirebaseFirestore.instance
                  .collection('permission_Requests')
                  .add({
                'staffMemberId': request.staffmemberId,
                'subject': request.subject,
                'description': request.description,
                'status': request.status,
                'ccmemberId': request.ccmemberId,
              });

              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardCc()));
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subject.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<String?> fetchcollegeid(String documentId) async {
    try {
      // Create a reference to the document using the UID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(documentId)
              .get();

      // Check if the document exists
      if (userSnapshot.exists) {
        // Retrieve data from the document
        Map<String, dynamic> userData = userSnapshot.data()!;
        String? collegeid = userData['collegeId'];

        // Use the retrieved data
        print('collegeId: $collegeid');
        // Return the document ID
        return collegeid;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  Future<String?> fetchUID(String uid) async {
    try {
      // Query for the document where the 'uid' field matches the user's UID
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('user_ID', isEqualTo: uid)
              .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document, get its ID
        String documentId = querySnapshot.docs.first.id;
        print('Document ID found for the user: $documentId');
        return documentId;
      } else {
        print('Document does not exist for the user');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }
}

class permissionRequest {
  final String staffmemberId;
  final String subject;
  final String description;
  final String status;
  final String ccmemberId;
  permissionRequest({
    required this.staffmemberId,
    required this.subject,
    required this.description,
    required this.status,
    required this.ccmemberId,
  });
}
