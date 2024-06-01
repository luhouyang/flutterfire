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
    // initialize title, content
    titleController.text = widget.noteEntity.title;
    contentController.text = widget.noteEntity.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const MyTitle(text: "Edit Note"),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              MyInput(
                  controller: titleController, labelText: "title", height: 50),
              const SizedBox(
                height: 10,
              ),
              MyInput(
                  controller: contentController,
                  labelText: "content",
                  height: MediaQuery.of(context).size.height * 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  updateNoteButton(),
                  deleteNoteButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget updateNoteButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
      onPressed: () async {
        // make new note entity and call database model update, then pop context
        NoteEntity noteEntity = NoteEntity(
            docId: widget.noteEntity.docId,
            title: titleController.text,
            content: contentController.text,
            checked: widget.noteEntity.checked,
            date: widget.noteEntity.date);

        await DatabaseModel().updateNote(noteEntity).then((value) {
          Navigator.pop(context);
        });
      },
      child: const Text("Update Note"),
    );
  }

  Widget deleteNoteButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.red)),
      onPressed: () async {
        // call database model delete, then pop context
        await DatabaseModel().deleteNote(widget.noteEntity.docId).then((value) {
          Navigator.pop(context);
        });
      },
      child: const Text("Delete Note"),
    );
  }
}
