import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticateService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollectionRef = FirebaseFirestore.instance.collection('users');

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _addUserDetails(userCredential.user!, email, password);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _addUserDetails(User user, String email, String password) async {
    await _usersCollectionRef.doc(user.uid).set({
      'email': email,
      'password': password,
    });
  }
}
