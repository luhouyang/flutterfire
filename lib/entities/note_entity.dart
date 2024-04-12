//TODO: add as needed
class NoteEntity {
  String title;
  String content;
  // done: bool
  // date: DateTime
  // tags: List<dynamic>

  NoteEntity({required this.title, required this.content});

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(title: map['title'], content: map['content']);
  }

  toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
