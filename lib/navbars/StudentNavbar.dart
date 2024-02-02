import 'package:club_hub/clubsinfo.dart';
import 'package:flutter/material.dart';
class StudentNavbar extends StatelessWidget {
  const StudentNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Clubs info'),
            onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context)=> ClubsInfo()))
          ),
          ListTile(
            title: Text('Membership History '),
            onTap: () => print('clubs'),
          ),
          ListTile(
            title: Text('My Clubs'),
            onTap: () => print('clubs'),
          ),
        ],
      ),
    );
  }
}