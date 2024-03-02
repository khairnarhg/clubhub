import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:club_hub/clubs_info.dart';
import 'package:club_hub/pr_staff.dart';
import 'package:flutter/material.dart';

class StaffNavbar extends StatelessWidget {
  final String currentdocid;

  StaffNavbar({Key? key, required this.currentdocid}) : super(key: key);

  Future<String?> getConvenerClubId(String docid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> currentuserinfo =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(docid)
              .collection('permission_requests')
              .get();
      print(currentuserinfo.docs.first.id);
      String clubId = currentuserinfo.docs.first.id;
      return clubId;
    } catch (e) {
      print('Some error occured');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: const Text('Clubs info'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ClubsInfo()))),
          ListTile(
              title: const Text('Permission Requests'),
              onTap: () async {
                 String? clubid = await getConvenerClubId(currentdocid);

                 print(currentdocid);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PermissionRequestsScreen(clubId: clubid.toString(), currdocid: currentdocid,)));
              }),
        ],
      ),
    );
  }
}
