import 'package:club_hub/Welcome.dart';
import 'package:club_hub/navbars/StudentNavbar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavbar(),
      appBar: AppBar(
        title: Text('Welcome student'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
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
