import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/club_duties.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PermissionRequestForm extends StatefulWidget {
  final String staffmember;
  final String clubId;
  const PermissionRequestForm(
      {Key? key, required this.staffmember, required this.clubId})
      : super(key: key);

  @override
  State<PermissionRequestForm> createState() => _PermissionRequestFormState();
}

class _PermissionRequestFormState extends State<PermissionRequestForm> {
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _prid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create PR'),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _prid,
            decoration:
                const InputDecoration(labelText: 'Permission Request ID'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _subject,
            decoration: const InputDecoration(labelText: 'Subject'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _description,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: null,
          ),
          ElevatedButton(
            onPressed: () async {
              String subject = _subject.text;
              String description = _description.text;
              String staffmembernumber = widget.staffmember;
              String prid = _prid.text;

              String? uid = FirebaseAuth.instance.currentUser?.uid;
              String? documentId = await fetchUID(uid!);
              String? ccmemberId = await fetchcollegeid(documentId!);

              permissionRequest request = permissionRequest(
                  clubid: widget.clubId,
                  prid: prid,
                  staffmemberId: staffmembernumber,
                  subject: subject,
                  description: description,
                  status: 'pending',
                  ccmemberId: ccmemberId.toString());

              await FirebaseFirestore.instance
                  .collection('clubs')
                  .doc(widget.clubId)
                  .collection('permissoin_requests')
                  .add({
                'clubid': widget.clubId,
                'prid': prid,
                'staffMemberId': request.staffmemberId,
                'subject': request.subject,
                'description': request.description,
                'status': request.status,
                'ccmemberId': request.ccmemberId,
              });

              QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore
                  .instance
                  .collection('users')
                  .where('collegeId', isEqualTo: staffmembernumber)
                  .get();

              if (docs.docs.isNotEmpty) {
                DocumentSnapshot<Map<String, dynamic>> userDoc =
                    docs.docs.first;
                CollectionReference<Map<String, dynamic>> newSubcollectionref =
                    userDoc.reference.collection('permission_requests');
                await newSubcollectionref.add({
                  'clubid': widget.clubId,
                  'prid': prid,
                  'subject': request.subject,
                  'description': request.description,
                  'status': request.status,
                  'ccmemberId': request.ccmemberId,
                });
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClubDuties(clubId: widget.clubId)));
            },
            child: const Text('Submit'),
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
  final String prid;
  final String clubid;

  final String staffmemberId;
  final String subject;
  final String description;
  final String status;
  final String ccmemberId;
  permissionRequest({
    required this.clubid,
    required this.prid,
    required this.staffmemberId,
    required this.subject,
    required this.description,
    required this.status,
    required this.ccmemberId,
  });
}
