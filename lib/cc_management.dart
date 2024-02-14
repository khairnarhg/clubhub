import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ccManagement extends StatefulWidget {
  final String docuementId;

  const ccManagement({Key? key, required this.docuementId}) : super(key: key);

  @override
  _ccManagementState createState() => _ccManagementState();
}

class _ccManagementState extends State<ccManagement> {
  List<String> clubNames = [];

  @override
  void initState() {
    super.initState();
    listUserClubs(widget.docuementId);
  }

  Future<void> listUserClubs(String documentId) async {
    try {
      // Query the 'users' collection for the current user's document
      DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(documentId)
              .get();
      print(userDocumentSnapshot.data());
      if (userDocumentSnapshot.data()!.containsKey('cc_info')) {
        print('cc_info exists');
      } else {
        print('false');
      }

      // Check if the 'cc_info' subcollection exists and is not empty
      if (userDocumentSnapshot.exists &&
          userDocumentSnapshot.data()!.containsKey('cc_info')) {
        print('cc_info exists');
        // Access the 'cc_info' subcollection
        QuerySnapshot<Map<String, dynamic>> ccInfoSnapshot =
            await userDocumentSnapshot.reference.collection('cc_info').get();
        print(ccInfoSnapshot.docs);

        // Check if there are any documents in the 'cc_info' subcollection
        if (ccInfoSnapshot.docs.isNotEmpty) {
          // Iterate over each document in the 'cc_info' subcollection
          ccInfoSnapshot.docs.forEach((ccDocument) {
            // Access the 'Club_name' field in each document
            String clubName = ccDocument['Club_name'];
            print(clubName);
            // Add the club name to the list
            setState(() {
              clubNames.add(clubName);
            });
          });
        }
      }
    } catch (error) {
      print('Error listing user clubs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage CC'),
      ),
      body: ListView.builder(
        itemCount: clubNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(clubNames[index]),
          );
        },
      ),
    );
  }
}
