import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';
import 'package:note/entities/user_entity.dart';

class DatabaseModel {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /* createUser function
  takes String newUid, String email, String name
  create a new UserEntity
  using "set" method
  catch error using "then" and "onError"
  */
  Future<void> createUser(String newUid, String email, String name) async {
    UserEntity userEntity = UserEntity(username: name, email: email);

    await firebaseFirestore
        .collection("users")
        .doc(newUid)
        .set(userEntity.toMap())
        .then((value) {
      debugPrint("Successfully created user");
    }).onError((error, stackTrace) {
      debugPrint("FAILED TO CREATE USER: $error");
    });
  }

  /* addNote function
  takes String title, String content
  get unique id from firestore, using ".doc().id"
  create a new NoteEntity
  using "set" method
  catch error using "then" and "onError"
  */
  Future<void> addNote(String title, String content) async {
    // get unique id from firestore
    String docRef = firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc()
        .id;

    // create note entity
    NoteEntity noteEntity = NoteEntity(
        docId: docRef,
        title: title,
        content: content,
        checked: false,
        date: Timestamp.fromDate(DateTime.now()));

    // create document on firestore
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(docRef)
        .set(noteEntity.toMap())
        .then((value) {
      debugPrint("Successfully added note");
    }).onError((error, stackTrace) {
      debugPrint("FAILED TO ADD NOTE: $error");
    });
  }

  // fetch note

  /* updateNote function
  takes NoteEntity noteEntity
  using "set" method
  catch error using "then" and "onError"
  */
  Future<void> updateNote(NoteEntity noteEntity) async {
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(noteEntity.docId)
        .set(noteEntity.toMap()).then((value) {
      debugPrint("Successfully updated note");
    }).onError((error, stackTrace) {
      debugPrint("FAILED TO UPDATE NOTE: $error");
    });
  }

  /* deleteNote function
  takes String docId
  using "delete" method
  catch error using "then" and "onError"
  */
  Future<void> deleteNote(String docId) async {
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(docId)
        .delete().then((value) {
      debugPrint("Successfully added note");
    }).onError((error, stackTrace) {
      debugPrint("FAILED TO DELETE NOTE: $error");
    });
  }
}
