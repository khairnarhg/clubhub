import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/cc_management.dart';
import 'package:club_hub/event_planning.dart';
import 'package:club_hub/post_invitation.dart';
import 'package:club_hub/release_p_r.dart';
import 'package:club_hub/clubs_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class stNavbar extends StatefulWidget {
  const stNavbar({super.key});

  @override
  State<stNavbar> createState() => _stNavbarState();
}

class _stNavbarState extends State<stNavbar> {
  Future<String?> fetchDocIdUsingUID(String uid) async {
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

  Future<bool> checkSubcollection(
      String documentId, String subcollectionName) async {
    try {
      // Get the reference to the document of the current user
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(documentId);

      // Get a snapshot of the document
      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      // Check if the document exists
      if (userDocSnapshot.exists) {
        // Check if the subcollection exists in the document
        CollectionReference subcollectionRef =
            userDocRef.collection(subcollectionName);
        QuerySnapshot subcollectionSnapshot =
            await subcollectionRef.limit(1).get();
        return subcollectionSnapshot.docs.isNotEmpty;
      } else {
        // Document does not exist
        print('Document does not exist for user');
        return false;
      }
    } catch (error) {
      print('Error checking subcollection: $error');
      return false;
    }
  }

  void showNotMemberDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('Not a Core Committee Member'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Clubs info'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClubsInfo()),
            ),
          ),
          ListTile(
            title: Text('Membership History'),
            onTap: () async {
              String? user_Id = FirebaseAuth.instance.currentUser?.uid;
              String? DocumentId = await fetchDocIdUsingUID(user_Id!);
              bool is_member =
                  await checkSubcollection(DocumentId!, 'membership_info');
              print(is_member);
              if (is_member == true) {
              } else {
                showNotMemberDialog(
                    context, 'You are not a member of any club');
              }
            },
          ),
          ListTile(
            title: Text('Post Invitation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostInvitation()),
            ),
          ),
          // Display the current user's ID

          ListTile(
              title: Text('Release PR'),
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReleasePR()))
                  }),
          ListTile(
            title: Text('Event Planning'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventPlanning()))
            },
          ),

          // Add a ListTile for cc management if the user is a core committee member

          ListTile(
            title: Text('CC Management'),
            onTap: () async {
              String? user_Id = FirebaseAuth.instance.currentUser?.uid;
              String? DocumentId = await fetchDocIdUsingUID(user_Id!);
              bool is_ccmember =
                  await checkSubcollection(DocumentId!, 'cc_info');
              print(is_ccmember);
              if (is_ccmember == true) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ccManagement(docuementId: DocumentId ,)));
              } else {
                showNotMemberDialog(context, 'You are not a member of any cc');
              }
            },
          ),
        ],
      ),
    );
  }
}
