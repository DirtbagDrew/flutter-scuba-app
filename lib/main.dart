import 'package:flutter/material.dart';
import 'package:scuba/src/Login.dart';
import 'package:scuba/src/Profile/Profile.dart';
import 'src/LogEntryForm/LogEntryForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dive Log',
      theme: ThemeData(
          primaryColor: Color(0xff03a9f4), accentColor: Color(0xffffd600)),
      home: Login(),
    );
  }
}
