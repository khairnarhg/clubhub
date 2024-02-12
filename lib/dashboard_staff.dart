import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/welcome.dart';
import 'package:club_hub/navbars/staff_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardStaff extends StatefulWidget {
  const DashboardStaff({Key? key}) : super(key: key);

  @override
  State<DashboardStaff> createState() => _DashboardStaffState();
}

class _DashboardStaffState extends State<DashboardStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StaffNavbar(),
      appBar: AppBar(
        title: const Text('Welcome Staff'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Welcome()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Invitations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> posts = snapshot.data!.docs;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                return ListTile(
                  title: const Text('AIDL'), // Name of the person who posted
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('${post['image']}'), // Image posted
                      const SizedBox(height: 8), // Spacer
                      Text('${post['caption']}'), // Caption
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
