import 'package:flutter/material.dart';
import 'package:scuba/src/Home.dart';
import 'package:scuba/src/Login.dart';
import 'package:scuba/src/Profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String id;

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSharedPreferences(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.getString('id') != null || id != null) {
              return Home();
            } else {
              return Login(
                idResult: (String result) {
                  setState(() {
                    id = result;
                  });
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
