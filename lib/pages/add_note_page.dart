import 'package:flutter/material.dart';
import 'package:note/model/database_model.dart';
import 'package:note/widgets/my_input.dart';
import 'package:note/widgets/my_title.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
              const MyTitle(text: "Make New Note"),
              MyInput(
                  controller: titleController, labelText: "title", height: 50),
              const SizedBox(
                height: 10,
              ),
              MyInput(
                  controller: contentController,
                  labelText: "content",
                  height: MediaQuery.of(context).size.height * 0.5),
              addNoteButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget addNoteButton() {
    return TextButton(
      style: const ButtonStyle(
          shape: MaterialStatePropertyAll(BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
          backgroundColor: MaterialStatePropertyAll(Colors.amber)),
      onPressed: () {
        DatabaseModel().addNote(titleController.text, contentController.text);
      },
      child: const Text(
        "Create Note",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
