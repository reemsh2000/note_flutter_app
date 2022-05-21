import 'package:flutter/material.dart';
import 'package:reem_notes/db/my_colors.dart';
import 'package:reem_notes/db/note.dart';
import 'package:reem_notes/db/db_helper.dart';

class AddNote extends StatefulWidget {
  final Note? note;
  final Function? onDelete;
  final Function refresh ;
  const AddNote({this.note, this.onDelete ,required this.refresh});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  static var db = DBHelper.dbHelper;
  bool editMode = false;
  int noteColor = 0xff1321E0;
  String title = "";
  String description = "";
  Future<void> insertUpdate() async {
    if (widget.note != null) {
      await db.updateNote(
        Note(
            title: _titleController.text,
            description: _descriptionController.text,
            noteColor: noteColor),
        widget.note?.id,
      );
    } else {
      await db.insertNewNote(Note(
          title: _titleController.text,
          description: _descriptionController.text,
          noteColor: noteColor));
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title);
    _descriptionController =
        TextEditingController(text: widget.note?.description);
    noteColor = widget.note?.noteColor ?? 0xff1321E0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(noteColor),
        actions: [
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => setState(() {
                    editMode = !editMode;
                  })),
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                await insertUpdate();
                await widget.refresh();
                Navigator.pop(context);
              }),
        ],
        title: const Center(
            child: Text('New Note',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 19, color: Colors.indigo),
              decoration: const InputDecoration(
                labelText: 'Title of your note',
                labelStyle: TextStyle(fontSize: 15, color: Colors.indigo),
                contentPadding: EdgeInsets.all(8.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 25, 43, 143)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: TextField(
              controller: _descriptionController,
              style: const TextStyle(fontSize: 15, color: Colors.indigo),
              decoration: const InputDecoration(
                labelText: 'Type your note here',
                labelStyle: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 1, 174, 180)),
                contentPadding: EdgeInsets.all(8.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 1, 174, 180)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 340,
          ),
          editMode
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 25, 43, 143),
                  ),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.share, color: Colors.white),
                        title: Text('Share with your friends',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.white),
                        title: const Text('Delete',
                            style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          await widget.onDelete!(widget.note?.id);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.copy, color: Colors.white),
                        title: const Text('Duplicate',
                            style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          await db.insertNewNote(Note(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              noteColor: noteColor));
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          itemCount: 11,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => {
                                setState(() {
                                  noteColor = myColors[index];
                                }),
                              },
                              child: Card(
                                  elevation: 0,
                                  color: const Color.fromARGB(255, 25, 43, 143),
                                  child: SizedBox(
                                    child: CircleAvatar(
                                        backgroundColor:
                                            Color(myColors[index])),
                                  )),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(
                  height: 10,
                )
        ]),
      ),
    );
  }
}
