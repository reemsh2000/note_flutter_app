import 'package:reem_notes/db/db_controller.dart';
import 'package:reem_notes/db/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDbController<T> {
  final Database _database = DbController().database;

  Future<int> create(Note object) async {
    int newRowId = await _database.insert('notes', object.toMap());
    return newRowId;
  }

  Future<bool> delete(int id) async {
    int numOfDeletedRows =
        await _database.delete('notes', where: 'id=?', whereArgs: [id]);
    return numOfDeletedRows > 0;
  }

  Future<bool> update(Note object) async {
    int numOfUpdatedRows = await _database
        .update('notes', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return numOfUpdatedRows > 0;
  }

  Future<Note?> show(int id) async {
    List<Map<String, dynamic>> rows =
        await _database.query('notes', where: 'id=?', whereArgs: [id]);
    return rows.isNotEmpty ? Note.fromMap(rows.first) : null;
  }

  Future<List<Note>> read() async {
    List<Map<String, dynamic>> rows = await _database.query('notes');
    return rows.map((e) => Note.fromMap(e)).toList();
  }



}
