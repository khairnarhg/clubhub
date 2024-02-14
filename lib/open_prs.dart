import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:club_hub/dashboard_staff.dart';

import 'package:flutter/material.dart';

class OpenPrs extends StatefulWidget {
  const OpenPrs({super.key});

  @override
  State<OpenPrs> createState() => _OpenPrsState();
}

class _OpenPrsState extends State<OpenPrs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Prs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('permission_Requests')
            //.where('staffMemberId', isEqualTo: '183727')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> permissionRequests =
                snapshot.data!.docs;

            return ListView.builder(
              itemCount: permissionRequests.length,
              itemBuilder: (context, index) {
                var permissionRequest = permissionRequests[index];
                String documentId = permissionRequest.id;

                return ListTile(
                  title: Text('Subject: ' + permissionRequest['subject']),
                  subtitle: Text('Status:  ${permissionRequest['status']}'),
                  onTap: () {
                    // Navigate to a new screen with the description and Approve button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PermissionRequestDetailsScreen(
                          documentId: documentId,
                          description: permissionRequest['description'],
                        ),
                      ),
                    );
                  },
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

class PermissionRequestDetailsScreen extends StatelessWidget {
  final String documentId;
  final String description;

  const PermissionRequestDetailsScreen({
    required this.documentId,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Request Details'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text('Description:' + description),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle approval logic, e.g., update Firestore document status
              approvePermissionRequest(documentId);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardStaff()));
            },
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  // Add logic to update the permission request status to 'approved' in Firestore
  void approvePermissionRequest(String documentId) {
    FirebaseFirestore.instance
        .collection('permission_Requests')
        .doc(documentId)
        .update({'status': 'approved'});
  }
}
