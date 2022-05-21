import 'package:flutter/material.dart';
import './screens/welcome.dart';
import 'package:reem_notes/db/db_helper.dart';

void main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      title: 'Reem Notes',
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    ),
  );
}
