import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PermissionRequestsScreen extends StatelessWidget {
  final String clubId;
  final String currdocid;
  const PermissionRequestsScreen({
    required this.clubId,
    required this.currdocid,
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
              currdocid: currdocid,
            ),
            //     //     // Approved requests tab
            PermissionRequestsTab(
              status: 'approved',
              clubId: clubId,
              currdocid: currdocid,
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionRequestsTab extends StatelessWidget {
  final String status;
  final String clubId;
  final String currdocid;
  PermissionRequestsTab({
    required this.status,
    required this.clubId,
    required this.currdocid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currdocid)
            .collection('permission_requests')
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
                //print(documentId);
                String prid = permissionRequest['prid'];
                String clubid = permissionRequest['clubid'];

                return ListTile(
                  title: Text('Artificial Intelligence and Deep Learning Club'),
                  subtitle: Text('Subject: ' + permissionRequest['subject']),
                  //subtitle: Text('Status:  ${permissionRequest['status']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PermissionRequestDetailsScreen(
                          clubid: clubid,
                          documentId: documentId,
                          description: permissionRequest['description'],
                          clubId: clubId,
                          status: status,
                          currdocid: currdocid,
                          prid: prid,
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
  final String clubid;
  final String prid;
  final String documentId;
  final String description;
  final String clubId;
  final String status;
  final String currdocid;

  const PermissionRequestDetailsScreen({
    required this.clubid,
    required this.prid,
    required this.documentId,
    required this.description,
    required this.clubId,
    required this.status,
    required this.currdocid,
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
          if (status == 'pending')
            ElevatedButton(
              onPressed: () {
                approvePermissionRequest(prid, documentId, clubid, currdocid);
              },
              child: const Text('Approve'),
            ),
        ],
      ),
    );
  }

  // Add logic to update the permission request status to 'approved' in Firestore
  void approvePermissionRequest(
      String prid, String documentId, String clubid, String currdocid) async {
    print(currdocid);
    print(clubid);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('clubs')
        .doc(clubid)
        .collection('permissoin_requests')
        .where('prid', isEqualTo: prid)
        .get();

    // Check if any documents are found
    if (querySnapshot.docs.isNotEmpty) {
      print('not null');
      // Iterate over the documents found (there may be multiple if prid is not unique)
      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
          in querySnapshot.docs) {
        // Update the status field of each document to 'approved'
        await docSnapshot.reference.update({'status': 'approved'});
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot1 =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currdocid)
              .collection('permission_requests')
              .where('prid', isEqualTo: prid)
              .get();

      // Check if any documents are found
      if (querySnapshot1.docs.isNotEmpty) {
        print('not null');
        // Iterate over the documents found (there may be multiple if prid is not unique)
        for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot1
            in querySnapshot1.docs) {
          // Update the status field of each document to 'approved'
          await docSnapshot1.reference.update({'status': 'approved'});
        }
      }
    }
  }
}
