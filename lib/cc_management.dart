import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/club_duties.dart';
import 'package:flutter/material.dart';

class ccManagement extends StatelessWidget {
  final String DocumentId;

  const ccManagement({required this.DocumentId});

  Future<QuerySnapshot<Map<String, dynamic>>> accessCcInfo(
      String DocumentId) async {
    try {
      // Reference to the document
      DocumentReference documentRef =
          FirebaseFirestore.instance.collection('users').doc(DocumentId);

      // Access the subcollection within the document
      QuerySnapshot<Map<String, dynamic>> subcollectionSnapshot =
          await documentRef.collection('cc_info').get();

      return subcollectionSnapshot; // Return the snapshot
    } catch (e) {
      print('Error accessing subcollection: $e');
      throw e; // Throw the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CC Management'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: accessCcInfo(DocumentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Display the list of club names from cc_info
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var clubName = snapshot.data!.docs[index].data()['Club_name'];
                var position = snapshot.data!.docs[index].data()['Position'];
                return ListTile(
                  title: Text(clubName),
                  onTap: () {
                    // Handle onTap action here
                    if (position == 'Chairperson') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => clubDuties()));
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
