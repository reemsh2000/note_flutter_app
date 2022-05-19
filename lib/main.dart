import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reem_notes/db/db_controller.dart';
import 'package:reem_notes/db/note_provider.dart';
import './screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NoteProvider>(
        create: (context) => NoteProvider(),
      ),
    ],
    child: const MaterialApp(
      title: 'Reem Notes',
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    ),
  ));
}
