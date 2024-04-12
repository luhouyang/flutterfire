import 'package:flutter/material.dart';
import 'package:note/widgets/my_button.dart';
import 'package:note/widgets/my_input.dart';
import 'package:note/widgets/my_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MyTitle(text: "Make New Note"),
          MyInput(controller: titleController, labelText: "title", height: 30),
          MyInput(
              controller: contentController,
              labelText: "content",
              height: MediaQuery.of(context).size.height * 0.5),
          const MyButton(text: "Create Note"),
        ],
      ),
    );
  }
}
