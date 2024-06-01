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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const MyTitle(text: "Make New Note"),
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
              addNoteButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget addNoteButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
      onPressed: () async {
        // call database model add note, then pop context
        await DatabaseModel()
            .addNote(titleController.text, contentController.text)
            .then((value) {
          Navigator.pop(context);
        });
      },
      child: const Text("Create Note"),
    );
  }
}
