
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/EventPlanning.dart';
import 'package:club_hub/PostInvitation.dart';
import 'package:club_hub/ReleasePR.dart';
import 'package:club_hub/clubsinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class stNavbar extends StatefulWidget {
  const stNavbar({super.key});

  @override
  State<stNavbar> createState() => _stNavbarState();
}

class _stNavbarState extends State<stNavbar> {
  late String currentUserId;
  bool isCoreCommitteeMember = false;

 @override
  void initState(){
    super.initState();
    getCurrentUserId();
 }
  

  Future<void> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
      print(currentUserId);
      await checkccMember(currentUserId);
    } 
    
  }

  Future<void> checkccMember(String currentUserId) async {
    try {
      // Query the clubs collection to find documents where currentUserId is present in cc_members subcollection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collectionGroup('cc_members')
              .where('user_Id', isEqualTo: currentUserId)
              .get();

      // Check if any club documents are returned
      if (querySnapshot.docs.isNotEmpty) {
        // User is a core committee member of at least one club
        // Set the isCoreCommitteeMember flag to true
        
        setState(() {
          isCoreCommitteeMember = true;
        });
        print('User is a core committee member of at least one club');
      } else {
        print(querySnapshot.docs);
        // User is not a core committee member of any club
        print('User is not a core committee member of any club');
      }
    } catch (error) {
      print('Error checking membership: $error');
    }
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
            onTap: () => print('clubs'),
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
            title: Text('Current User ID: $currentUserId'),
          ),
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
          if (isCoreCommitteeMember)
            ListTile(
              title: Text('CC Management'),
              onTap: () {
                // Handle navigation or any action when the ListTile is tapped
              },
            ),
        ],
      ),
    );
  }
}