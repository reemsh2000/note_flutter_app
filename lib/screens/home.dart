import 'package:flutter/material.dart';
import 'package:reem_notes/db/note_provider.dart';
import 'package:reem_notes/screens/add_note.dart';
import 'package:provider/provider.dart';

import '../db/note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Note> notes;
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).read();
  }

  // Future refreshNotes() async {
  //   notes = await NotesDatabase.instance.readAllNotes();
  //   if (notes.length > 0) {
  //     NotesExist = true;
  //   }
  // }

  @override
  void dispose() {
    // NotesDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
          backgroundColor: Colors.indigo,
          title: const Center(
            child: Text(
              'My Notes',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Open Sans',
              ),
            ),
          ),
        ),
        body: Consumer<NoteProvider>(
          builder: (BuildContext context, NoteProvider value, child) {
            return value.notes.isNotEmpty
                ? Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        itemCount: value.notes.length,
                        itemBuilder: (context, index) {
                          // if (widget.note != null) {
                          //   value.notes[index] = widget.note;
                          // }
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddNote(
                                    note: value.notes[index],
                                    // appColor: widget.mainColor,
                                  );
                                },
                              ),
                            ),
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
                                        color:
                                            Color(value.notes[index].noteColor),
                                        width: 7,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          value.notes[index].title,
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 18,
                                            color: Color(0XFF1321E0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          value.notes[index].description,
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 650, left: 350),
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/new_note_screen');
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Icon(
                              Icons.add,
                              size: 45,
                              color: Colors.white,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0XFF072DDE),
                                  Color(0XFFAD0CBF),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                :   Stack(
                      children: [
                        const SizedBox(
                          height: 170,
                        ),
                        SizedBox(
                            width: 230,
                            height: 230,
                            child: Image.network(
                                "https://img.freepik.com/free-vector/copywriting-writing-icon-creative-writing-storytelling-3d-vector-illustration_365941-591.jpg")),
                        const SizedBox(
                          height: 270,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 300,
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.indigo,
                              onPressed: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const AddNote();
                                }))
                              },
                              tooltip: 'Increment',
                              child: const Icon(Icons.add),
                            ),
                          ],
                        )
                      ],
                    );
          }),
        );
  }
}
