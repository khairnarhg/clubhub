import 'package:club_hub/Welcome.dart';
import 'package:club_hub/navbars/ccnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardCc extends StatefulWidget {
  const DashboardCc({super.key});

  @override
  State<DashboardCc> createState() => _DashboardCcState();
}

class _DashboardCcState extends State<DashboardCc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CcNavBar(),
      appBar: AppBar(
        title: Text('Welcome CC member'),
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