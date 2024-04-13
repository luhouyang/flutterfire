import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';
import 'package:note/model/database_model.dart';
import 'package:note/pages/add_note_page.dart';
import 'package:note/pages/update_note_page.dart';
import 'package:note/widgets/my_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNotePage(),
              ));
        },
      ),
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("notes").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  NoteEntity noteEntity =
                      NoteEntity.fromMap(snapshot.data!.docs[index].data());

                  return noteCard(noteEntity);
                },
              );
            },
          )),
    );
  }

  Widget noteCard(NoteEntity noteEntity) {
    return InkWell(
      onHover: (value) {},
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNotePage(noteEntity: noteEntity),));
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shadowColor: Colors.black,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  MyTitle(text: noteEntity.title),
                  const Divider(
                    height: 2,
                  ),
                  Text(
                    noteEntity.content,
                    textAlign: TextAlign.start,
                  )
                ],
              ),
              Checkbox(
                value: noteEntity.checked,
                onChanged: (value) async {
                  noteEntity.checked = !noteEntity.checked;
                  await DatabaseModel().updateNote(noteEntity);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
