import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final double height;

  const MyInput(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        maxLines: null,
        expands: true,
        controller: controller,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          label: Text(labelText),
          fillColor: Colors.grey[200],
          focusColor: Colors.grey[100],
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
