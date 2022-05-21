import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:reem_notes/db/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper with ChangeNotifier {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static const String noteTitleColumn = "title";
  static const String noteDescriptionColumn = 'description';
  static const String notesColorColumn = 'notecolor';
  Future<Database> initDataBase() async {
    Database database = await connectToDatabase();
    return database;
  }

  Future<Database> connectToDatabase() async {
    Directory appfolder = await getApplicationDocumentsDirectory();
    String appPath = appfolder.path;
    String dbPath = join(appPath, "reem.db");
    Database database = await openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, $noteTitleColumn TEXT, $noteDescriptionColumn TEXT, $notesColorColumn INTEGER )');
    }, onOpen: (database) {
      print(database.path);
    }, version: 1);
    return database;
  }

  insertNewNote(Note note) async {
    Database db = await initDataBase();
    int rowNo = await db.insert("note", note.toMap());
    print(rowNo);
    notifyListeners();
  }

  Future<List<Note>> getAllNotesFunc() async {
    Database db = await initDataBase();
    List result = await db.query("note");
    List<Note> notes = result.map((e) {
      return Note.fromMap(e);
    }).toList();
    notifyListeners();
    return notes;
  }

  Future<Note> getSpecifucNote(int id) async {
    Database db = await initDataBase();
    List result =
        await db.query("note", where: "id=?", whereArgs: [id], limit: 1);
    Note note = Note.fromMap(result.first);
    notifyListeners();
    return note;
  }

  deleteNote(int id) async {
    Database db = await initDataBase();
    db.delete("note", where: "id=?", whereArgs: [id]);
    notifyListeners();
  }

  updateNote(Note note, id) async {
    try {
      Database db = await initDataBase();
      db.update("note", note.toMap(), where: "id=?", whereArgs: [id]);
    } on Exception catch (e) {
      print("error");
    }
  }

  List<Note> allNotes = [];



}
