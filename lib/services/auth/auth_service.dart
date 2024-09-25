import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //currentuser
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  //signUp
  Future<UserCredential> singUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _firestore
          .collection('users')
          .doc(user.user!.uid)
          .set({'uid': user.user!.uid, 'email': email});

      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
