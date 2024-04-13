class NoteEntity {
  String docId;
  String title;
  String content;
  bool checked;
  // date: DateTime
  // tags: List<dynamic>

  NoteEntity(
      {required this.docId,
      required this.title,
      required this.content,
      required this.checked});

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
        docId: map['docId'],
        title: map['title'],
        content: map['content'],
        checked: map['checked']);
  }

  toMap() {
    return {
      'docId': docId,
      'title': title,
      'content': content,
      'checked': checked,
    };
  }
}
