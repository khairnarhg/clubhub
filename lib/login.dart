import "package:cloud_firestore/cloud_firestore.dart";
import "package:club_hub/dashboard_cc.dart";
import "package:club_hub/dashboard_staff.dart";
import "package:club_hub/dashboard_student.dart";
import "package:club_hub/firebase_auth_services.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'E-mail Id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pass,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _email.text;
    String password = _pass.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      String? documentId = await fetchDataUsingUID(uid!);

      if (documentId != null) {
        print('Document ID of the logged-in user: $documentId');
        await fetchdataandopendashboard(documentId);
      } else {
        print('Document does not exist for the logged-in user');
      }

      print('User is successfully signed in');
    } else {
      print('Some error occurred');
    }
  }

  Future<String?> fetchdataandopendashboard(String documentId) async {
    try {
      // Create a reference to the document using the UID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(documentId)
              .get();

      // Check if the document exists
      if (userSnapshot.exists) {
        // Retrieve data from the document
        Map<String, dynamic> userData = userSnapshot.data()!;
        String? role = userData['role'];
        
        // Use the retrieved data
        print('Role: $role');

        if(role=='Student'){
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
        }
        else if(role=='Staff'){
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardStaff()));
        }
        else{
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardCc()));
        }

        // Return the document ID
        return userSnapshot.id;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  Future<String?> fetchDataUsingUID(String uid) async {
    try {
      // Query for the document where the 'uid' field matches the user's UID
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('user_ID', isEqualTo: uid)
              .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document, get its ID
        String documentId = querySnapshot.docs.first.id;
        print('Document ID found for the user: $documentId');
        return documentId;
      } else {
        print('Document does not exist for the user');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }
}
