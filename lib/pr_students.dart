import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PermissionRequestsScreenStudents extends StatelessWidget {
  final String clubId;
  const PermissionRequestsScreenStudents({
    required this.clubId,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Permission Requests'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //     //     Pending requests tab
            PermissionRequestsTab(
              status: 'pending',
              clubId: clubId,
            ),
            //     //     // Approved requests tab
            PermissionRequestsTab(status: 'approved', clubId: clubId),
          ],
        ),
      ),
    );
  }
}

class PermissionRequestsTab extends StatelessWidget {
  final String status;
  final String clubId;
  PermissionRequestsTab({
    required this.status,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('clubs')
            .doc(clubId)
            .collection('permissoin_requests')
            .where('status', isEqualTo: status)
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
                  // title: Text('Artificial Intelligence and Deep Learning Club'),
                  title: Text('Subject: ' + permissionRequest['subject']),
                subtitle: Text('Status:  ${permissionRequest['status']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PermissionRequestDetailsScreen(
                          documentId: documentId,
                          description: permissionRequest['description'],
                          clubId: clubId,
                          status: status,
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
  final String clubId;
  final String status;

  const PermissionRequestDetailsScreen({
    required this.documentId,
    required this.description,
    required this.clubId,
    required this.status,
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
          Center(
            child: Text('Status:' + status),
          ),
          // if (status == 'pending')
          //   ElevatedButton(
          //     onPressed: () {
          //       approvePermissionRequest(documentId);
          //     },
          //     child: const Text('Approve'),
          //   ),
        ],
      ),
    );
  }

  // Add logic to update the permission request status to 'approved' in Firestore
  void approvePermissionRequest(String documentId) {
    FirebaseFirestore.instance
        .collection('clubs')
        .doc(clubId)
        .collection('permissoin_requests')
        .doc(documentId)
        .update({'status': 'approved'});
  }
}


