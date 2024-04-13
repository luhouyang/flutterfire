import 'package:flutter/material.dart';
import 'package:note/entities/note_entity.dart';
import 'package:note/model/database_model.dart';
import 'package:note/widgets/my_input.dart';
import 'package:note/widgets/my_title.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteEntity noteEntity;

  const UpdateNotePage({super.key, required this.noteEntity});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.noteEntity.title;
    contentController.text = widget.noteEntity.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const MyTitle(text: "Edit Note"),
              MyInput(
                  controller: titleController, labelText: "title", height: 50),
              const SizedBox(
                height: 10,
              ),
              MyInput(
                  controller: contentController,
                  labelText: "content",
                  height: MediaQuery.of(context).size.height * 0.5),
              updateNoteButton(),
              deleteNoteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget updateNoteButton() {
    return TextButton(
      style: const ButtonStyle(
          shape: MaterialStatePropertyAll(BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
          backgroundColor: MaterialStatePropertyAll(Colors.amber)),
      onPressed: () async {
        NoteEntity noteEntity = NoteEntity(
            docId: widget.noteEntity.docId,
            title: titleController.text,
            content: contentController.text,
            checked: widget.noteEntity.checked);

        await DatabaseModel().updateNote(noteEntity).then((value) {
          Navigator.pop(context);
        });
      },
      child: const Text(
        "Update Note",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget deleteNoteButton() {
    return TextButton(
      style: const ButtonStyle(
          shape: MaterialStatePropertyAll(BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
          backgroundColor: MaterialStatePropertyAll(Colors.red)),
      onPressed: () async {
        await DatabaseModel().deleteNote(widget.noteEntity.docId).then((value) {
          Navigator.pop(context);
        });
      },
      child: const Text(
        "Delete Note",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
