import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/Welcome.dart';
import 'package:club_hub/navbars/ccnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardCc extends StatefulWidget {
  const DashboardCc({super.key});

  @override 
  State<DashboardCc> createState() => _DashboardCcState();
}

class _DashboardCcState extends State<DashboardCc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CcNavBar(),
      appBar: AppBar(
        title: Text('Welcome CC member'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed:(){
              FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Welcome()));
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
                  title: Text('AIDL'), // Name of the person who posted
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('${post['image']}'), // Image posted
                      SizedBox(height: 8), // Spacer
                      Text('${post['caption']}'), // Caption
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}