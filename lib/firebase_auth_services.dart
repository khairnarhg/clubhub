

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String collegeId, String fullname, role) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      await _addUserDataToFirestore(user?.uid, fullname, collegeId, role, email, password);

      return user;
    } catch (e) {
      print('Some error occured');
    }
    return null;
  }

  Future<void> _addUserDataToFirestore(String? userId, String fullName,
      String collegeId, String role, String email, String password) async {
    if (userId != null) {
      try {
        // Reference to the Firestore collection
        CollectionReference users = _firestore.collection('users');

        // Add a new document with the user's ID
        await users.add({
          'user_ID': userId,
          'fullName': fullName,
          'collegeId': collegeId,
          'role': role,
          'email': email,
          'password': password,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print('User data stored in Firestore successfully.');
      } catch (e) {
        print('Error storing user data in Firestore: $e');
      }
    }
  }


  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('Some error occured');
    }
    return null;
  }
}
