import 'package:club_hub/comment_screen.dart';
import 'package:club_hub/navbars/student_navbar.dart';
import 'package:club_hub/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({Key? key}) : super(key: key);
  @override
  State<DashboardStudent> createState() => DashboardStudentState();
}

class DashboardStudentState extends State<DashboardStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StudentNavbar(),
      appBar: AppBar(
        title: const Text('Welcome student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Welcome()),
              );
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
                QueryDocumentSnapshot post = posts[index];
                return ListTile(
                  title: Text(post['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(post['image']),
                      const SizedBox(height: 8),
                      Text(post['caption']),
                    ],
                  ),
                  // Add an onTap callback to navigate to the comment screen.
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(post: post),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
