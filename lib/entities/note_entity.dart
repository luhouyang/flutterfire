import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEntity {
  String docId;
  String title;
  String content;
  bool checked;
  Timestamp date;

  NoteEntity(
      {required this.docId,
      required this.title,
      required this.content,
      required this.checked,
      required this.date});

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
        docId: map['docId'],
        title: map['title'],
        content: map['content'],
        checked: map['checked'],
        date: map['date']);
  }

  toMap() {
    return {
      'docId': docId,
      'title': title,
      'content': content,
      'checked': checked,
      'date': date,
    };
  }
}
