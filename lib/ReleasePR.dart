import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/PermissionRequestForm.dart';
import 'package:flutter/material.dart';

class ReleasePR extends StatefulWidget {
  const ReleasePR({super.key});

  @override
  State<ReleasePR> createState() => _ReleasePRState();
}

class _ReleasePRState extends State<ReleasePR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the staff member'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'Staff')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> staffMembers = snapshot.data!.docs;
            return ListView.builder(
              itemCount: staffMembers.length,
              itemBuilder: (context, index) {
                var staffMember = staffMembers[index];
                return ListTile(
                    title: Text(staffMember['fullName']),
                    onTap: () {
                      print('${staffMember['fullName']}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PermissionRequestForm(staffmember: '${staffMember['collegeId']}',)));
                    });
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
