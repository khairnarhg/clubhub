import 'package:club_hub/EventPlanning.dart';
import 'package:club_hub/PostInvitation.dart';
import 'package:club_hub/ReleasePR.dart';
import 'package:club_hub/clubsinfo.dart';
import 'package:flutter/material.dart';

class CcNavBar extends StatelessWidget {
  const CcNavBar({super.key});

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
            onTap: () =>{
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventPlanning()))
            },
          ),
          ListTile(
            title: Text('Post Invitation'),
            // onTap: () =>{
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => PostInvitation()))
            //},
          ),
        ],
      ),
    );
  }
}
