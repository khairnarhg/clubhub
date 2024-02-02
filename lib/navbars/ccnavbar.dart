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
          ListTile(title: Text('Release PR'), onTap: () => {}),
          ListTile(
            title: Text('Event Planning'),
            onTap: () => print('Plan Karo'),
          ),
          ListTile(
            title: Text('Post Invitation'),
          ),
        ],
      ),
    );
  }
}
