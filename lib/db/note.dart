class Note {
  late  int id;
  late  String title;
  late  String description;
  late  int noteColor;

  Note( {required this.title, required this.description, required this.noteColor});

  Note.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    title = rowMap['title'];
    description = rowMap['description'];
    noteColor = rowMap['notecolor'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> rowMap = <String, dynamic>{};
    rowMap['title'] = title;
    rowMap['description'] = description;
    rowMap['notecolor']=noteColor;
    return rowMap;
  }
}
