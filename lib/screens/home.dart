import 'package:flutter/material.dart';
import 'package:reem_notes/Components/note.dart';
import 'package:reem_notes/db/db_helper.dart';
import 'package:reem_notes/db/note.dart';
import 'package:reem_notes/screens/add_note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late var notes;
  static var db = DBHelper.dbHelper;
 Future<dynamic> _notes=Future<dynamic>(() => db.getAllNotesFunc());

  Future <void> refreshNotes() async {
    notes = await db.getAllNotesFunc();
    setState(() {
      _notes =Future<dynamic>(()=>notes) ;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> onDelete(int id) async {
    DBHelper db = DBHelper.dbHelper;
    db.deleteNote(id);
    await refreshNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: _notes,
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Column(
                        children: const [
                          SizedBox(
                            height: 250,
                          ),
                          CircularProgressIndicator(),
                        ],
                      );
                    case ConnectionState.done:
                      if (snapshot.data.length == 0) {
                        return Column(
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
                              height: 240,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 300,
                                ),
                                FloatingActionButton(
                                  backgroundColor: Colors.indigo,
                                  onPressed: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return  AddNote(refresh: refreshNotes);
                                    }))
                                  },
                                  tooltip: 'Increment',
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(children: [
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return NoteComponent(
                                    snapshot.data[index], onDelete,refreshNotes);
                              },
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 200, left: 300),
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return  AddNote(refresh: refreshNotes);
                                        // );
                                      },
                                    ),
                                  );
                                },
                                backgroundColor: Colors.indigo,
                                child: const Icon(
                                  Icons.add,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                        );
                      }
                    // break;
                    case ConnectionState.none:
                      return const Center(
                        child: Text("Error"),
                      );
                    case ConnectionState.active:
                      return const Center(
                        child: Text("Error !!"),
                      );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
