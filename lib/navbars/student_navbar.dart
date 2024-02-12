import 'package:cloud_firestore/cloud_firestore.dart'; // Import the cloud_firestore package
import 'package:club_hub/event_planning.dart';
import 'package:club_hub/post_invitation.dart';
import 'package:club_hub/release_p_r.dart';
import 'package:club_hub/clubs_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentNavbar extends StatefulWidget {
  const StudentNavbar({super.key});

  @override
  State<StudentNavbar> createState() => _StudentNavbarState();
}

class _StudentNavbarState extends State<StudentNavbar> {
  late String currentUserId;
  bool isCoreCommitteeMember = false;

  @override
  void initState() {
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
      await checkccMember(currentUserId); // Call the checkccMember method
    }
  }

  Future<void> checkccMember(String currentUserId) async {
    try {
      // Query the clubs collection to find documents where currentUserId is present in cc_members subcollection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('clubs') // Use the clubs collection
              .where('cc_members',
                  arrayContains: currentUserId) // Filter by the current user ID
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
            title: const Text('Clubs info'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClubsInfo()),
            ),
          ),
          ListTile(
            title: const Text('Membership History'),
            onTap: () => print('clubs'),
          ),
          ListTile(
            title: const Text('Post Invitation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostInvitation()),
            ),
          ),
          // Display the current user's ID
          ListTile(
            title: Text('Current User ID: $currentUserId'),
          ),
          ListTile(
              title: const Text('Release PR'),
              onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReleasePR()))
                  }),
          ListTile(
            title: const Text('Event Planning'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventPlanning()))
            },
          ),

          // Add a ListTile for cc management if the user is a core committee member
          if (isCoreCommitteeMember)
            ListTile(
              title: const Text('CC Management'),
              onTap: () {
                // Handle navigation or any action when the ListTile is tapped
              },
            ),
        ],
      ),
    );
  }
}
