import 'package:flutter/material.dart';
import 'package:club_hub/screens/student.dart';
import 'package:club_hub/screens/cc.dart';
import 'package:club_hub/screens/staff.dart';

class RoleSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleButton(context, 'Student'),
            SizedBox(height: 16),
            _buildRoleButton(context, 'Staff'),
            SizedBox(height: 16),
            _buildRoleButton(context, 'Core Committee'),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String role) {
    return ElevatedButton(
      onPressed: () {
        _navigateToDashboard(context, role);
      },
      child: Text(role),
    );
  }

  void _navigateToDashboard(BuildContext context, String role) {
    // Implement navigation logic here based on the selected role
    switch (role) {
      case 'Student':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StudentInterface()));
        break;
      case 'Staff':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StaffInterface()));
        break;
      case 'Core Committee':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CCInterface()));
        break;
      default:
        // Handle unexpected cases
        break;
    }
  }
}
