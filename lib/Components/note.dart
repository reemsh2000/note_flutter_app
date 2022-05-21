import 'package:flutter/material.dart';
import 'package:reem_notes/screens/add_note.dart';
import '../db/note.dart';

class NoteComponent extends StatefulWidget {
  final Note note;
  final Function onDelete;
  final Function refresh;

  // ignore: use_key_in_widget_constructors
  const NoteComponent(this.note, this.onDelete, this.refresh);

  @override
  State<NoteComponent> createState() => _NoteComponentState();
}

class _NoteComponentState extends State<NoteComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AddNote(
                note: widget.note,
                onDelete: widget.onDelete,
                refresh: widget.refresh);
            // );
          },
        ),
      ),
      child: Container(
        height: 90,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.grey,
            elevation: 5,
            child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Color(widget.note.noteColor),
                          width: 7,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListTile(
                        title: Text(
                          widget.note.title,
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 19,
                            color: Color(0XFF1321E0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.note.description,
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async =>
                              {widget.onDelete(widget.note.id)},
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    )))),
      ),
    );
  }
}
