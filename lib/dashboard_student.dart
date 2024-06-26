import 'package:club_hub/comment_screen.dart';
import 'package:club_hub/navbars/StudentNavbar.dart';
import 'package:club_hub/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({super.key});

  @override
  State<DashboardStudent> createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  late Future<List<Map<String, dynamic>>> _invitations;

  @override
  void initState() {
    super.initState();
    _invitations = getInvitations();
  }

  Future<List<Map<String, dynamic>>> getInvitations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> gettingAllDocs =
          await FirebaseFirestore.instance.collection('clubs').get();

      List<Map<String, dynamic>> invitationsData = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
          in gettingAllDocs.docs) {
        String clubId = docSnapshot.id;

        QuerySnapshot<Map<String, dynamic>> eventsDocs = await FirebaseFirestore
            .instance
            .collection('clubs')
            .doc(clubId)
            .collection('Events')
            .get();
        for (QueryDocumentSnapshot<Map<String, dynamic>> eventsDocSnapshot
            in eventsDocs.docs) {
          String eventsDocId = eventsDocSnapshot.id;
          QuerySnapshot<Map<String, dynamic>> invitationDocs =
              await FirebaseFirestore.instance
                  .collection('clubs')
                  .doc(clubId)
                  .collection('Events')
                  .doc(eventsDocId)
                  .collection('Invitations')
                  .get();
          for (QueryDocumentSnapshot<Map<String, dynamic>> invitationDocSnapshot
              in invitationDocs.docs) {
            invitationsData.add(invitationDocSnapshot.data());
          }
        }
      }

      return invitationsData;
    } catch (e) {
      print('Error occurred: $e');
      throw e; // Rethrow the exception to handle it in the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const stNavbar(),
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _invitations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final invitationData = snapshot.data![index];
                final clubName = invitationData['clubName'] as String?;
                final caption = invitationData['caption'] as String?;
                final image = invitationData['image'] as String?;

                return ListTile(
                  title: Text(clubName ?? 'No Club Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(image ?? ''),
                      const SizedBox(height: 8),
                      Text(caption ?? 'No Caption'),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Register Now'),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentScreen()));
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
