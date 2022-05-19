import 'package:flutter/material.dart';

import '../db/note.dart';

class NoteComponent extends StatefulWidget {
  final Note note;
  const NoteComponent(this.note);

  @override
  State<NoteComponent> createState() => _NoteComponentState();
}

class _NoteComponentState extends State<NoteComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Card(
          color: Color(widget.note.noteColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.note.description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
