
import 'package:club_hub/clubsinfo.dart';
import 'package:flutter/material.dart';

class StaffNavbar extends StatelessWidget {
  const StaffNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text('Clubs info'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClubsInfo()))
                  ),
          ListTile(title: Text('Open PRs'), onTap: () => {}
          ),
        ],
      ),
    );
  }
}
