import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';
import 'package:note/entities/user_entity.dart';

class DatabaseModel {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // add user
  Future<void> createUser(String newUid, String email, String name) async {
    UserEntity userEntity = UserEntity(username: name, email: email);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(newUid)
        .set(userEntity.toMap());
  }

  // add note
  Future<void> addNote(String title, String content) async {
    // add note to "notes" collection
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String docRef = firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc()
        .id;

    NoteEntity noteEntity = NoteEntity(
        docId: docRef, title: title, content: content, checked: false);

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

    // add note id to "users" collection
  }

  // fetch note

  // update note
  Future<void> updateNote(NoteEntity noteEntity) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(noteEntity.docId)
        .set(noteEntity.toMap());
  }

  // delete note
  Future<void> deleteNote(String docId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(docId)
        .delete();
  }
}
