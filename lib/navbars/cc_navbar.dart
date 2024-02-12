import 'package:club_hub/event_planning.dart';
import 'package:club_hub/post_invitation.dart';
import 'package:club_hub/release_p_r.dart';
import 'package:club_hub/clubs_info.dart';
import 'package:flutter/material.dart';

class CcNavbar extends StatelessWidget {
  const CcNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text('Clubs info'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClubsInfo()))),
          ListTile(
              title: Text('Release PR'),
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReleasePR()))
                  }),
          ListTile(
            title: Text('Event Planning'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventPlanning()))
            },
          ),
          ListTile(
            title: Text('Post Invitation'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostInvitation()))
            },
          ),
        ],
      ),
    );
  }
}
