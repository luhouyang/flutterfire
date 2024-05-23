import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';
import 'package:note/entities/user_entity.dart';

class DatabaseModel {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // add user
  Future<void> createUser(String newUid, String email, String name) async {
    UserEntity userEntity = UserEntity(username: name, email: email);

    await firebaseFirestore
        .collection("users")
        .doc(newUid)
        .set(userEntity.toMap());
  }

  // add note
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
        docId: docRef, title: title, content: content, checked: false, date: Timestamp.fromDate(DateTime.now()));

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
      debugPrint("ERROR: ${error.toString()}");
    });
  }

  // fetch note

  // update note
  Future<void> updateNote(NoteEntity noteEntity) async {
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(noteEntity.docId)
        .set(noteEntity.toMap());
  }

  // delete note
  Future<void> deleteNote(String docId) async {
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(docId)
        .delete();
  }
}
