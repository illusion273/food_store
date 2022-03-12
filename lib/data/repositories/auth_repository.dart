import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//TEMP
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  // TODO: Refactor for Dependency Inversion
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> getAuthStateChanges() {
    return _firebaseAuth.authStateChanges().asyncMap(
      (firebaseUser) async {
        if (firebaseUser != null) {
          print('Authentication Repository:\n');
          print('User ${firebaseUser.uid} signed in' '\n');

          // TEMPORARY
          // Creates user entry to firestore after signup
          // ASAP Convert this code to cloud function
          final FirebaseFirestore _db = FirebaseFirestore.instance;
          var snapshot =
              await _db.collection('users').doc(firebaseUser.uid).get();
          if (!snapshot.exists) {
            try {
              await _db.collection('users').doc(firebaseUser.uid).set({
                'uid': firebaseUser.uid,
                'email': firebaseUser.email,
              });
            } catch (e) {
              throw Exception(e);
            }
          } // END
          return firebaseUser.uid;
        } else {
          print('Authentication Repository:\n');
          print('User is signed out!\n');
          return "";
        }
      },
    );
  }

  Future signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception(e);
    }
  }
}
