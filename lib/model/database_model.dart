import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';

class DatabaseModel {
  // add note
  Future<void> addNote(String title, String content) async {
    // add note to "notes" collection
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String docRef = firebaseFirestore.collection("notes").doc().id;

    NoteEntity noteEntity = NoteEntity(
        docId: docRef, title: title, content: content, checked: false);

    await firebaseFirestore
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
        .collection("notes")
        .doc(noteEntity.docId)
        .set(noteEntity.toMap());
  }

  // delete note
  Future<void> deleteNote(String docId) async {
    await FirebaseFirestore.instance.collection("notes").doc(docId).delete();
  }
}
