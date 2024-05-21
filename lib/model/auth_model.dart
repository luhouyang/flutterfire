import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/model/database_model.dart';

class AuthModel {
  Future<void> signUp(BuildContext context, String email, String password,
      String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((UserCredential userCredential) {
        DatabaseModel().createUser(userCredential.user!.uid, email, username);
      });

      debugPrint("SIGNING UP");
    } catch (e) {
      // Handle authentication exceptions
      debugPrint("Error during create user: $e");
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("SIGNING IN");
    } catch (e) {
      // Handle authentication exceptions
      debugPrint("Error during sign-in: $e");
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle exceptions
      debugPrint("Error during send reset email: $e");
    }
  }
}
