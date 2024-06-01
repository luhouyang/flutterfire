import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';
import 'package:note/widgets/loading_text.dart';
import 'package:note/widgets/note_card.dart';

class NoteStream extends StatefulWidget {
  const NoteStream({super.key});

  @override
  State<NoteStream> createState() => _NoteStreamState();
}

class _NoteStreamState extends State<NoteStream> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("notes")
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingText();
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Notes", style: TextStyle(fontWeight: FontWeight.bold),));
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            NoteEntity noteEntity =
                NoteEntity.fromMap(snapshot.data!.docs[index].data());

            return NoteCard(
              noteEntity: noteEntity,
            );
          },
        );
      },
    );
  }
}
