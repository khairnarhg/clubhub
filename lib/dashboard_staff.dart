import 'package:club_hub/Welcome.dart';
import 'package:club_hub/navbars/staffnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardStaff extends StatefulWidget {
  const DashboardStaff({Key? key})
      : super(key: key);

  @override
  State<DashboardStaff> createState() => _DashboardStaffState();
}

class _DashboardStaffState extends State<DashboardStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StaffNavbar(),
      appBar: AppBar(
        title: Text('Welcome Staff'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed:(){
              FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Welcome()));
            },
          ),

        ],
      ),
    );
  }
}