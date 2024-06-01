import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:note/model/database_model.dart';

// implement AuthModel class
class AuthModel {

  /* signUp function, async, 
  takes BuildContext context, String email, String password, String username,
  using "createUserWithEmailAndPassword" method
  encapsulate with try-catch
  on error, show error message with showDialog
  return void */
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
        debugPrint("SIGNING UP");
      }).onError((error, stackTrace) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Error during create user: $error"),
                ),
              );
            });
      });
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      debugPrint("Error during create user: $e");
    }
  }

  /* signIn function, async, 
  takes BuildContext context, String email, String password,
  using "signInWithEmailAndPassword" method
  encapsulate with try-catch
  on error, show error message with showDialog
  return void */
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        debugPrint("SIGNING IN");
      }).onError((error, stackTrace) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Error during sign-in: $error"),
                ),
              );
            });
      });
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      debugPrint("Error during sign-in: $e");
    }
  }

  /* logout function, async, 
  doesn't take any arguments
  using "signOut" method
  encapsulate with try-catch
  return void */
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      debugPrint("Error during logout: $e");
    }
  }

  /* forgotPassword function, async, 
  takes BuildContext context, String email,
  using "sendPasswordResetEmail" method
  encapsulate with try-catch
  return void */
  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      debugPrint("Error during send reset email: $e");
    }
  }
}
