import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEntity {
  String docId;
  String title;
  String content;
  Timestamp date;

  NoteEntity(
      {required this.docId,
      required this.title,
      required this.content,
      required this.date});

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
        docId: map['docId'],
        title: map['title'],
        content: map['content'],
        date: map['date']);
  }

  toMap() {
    return {
      'docId': docId,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}
