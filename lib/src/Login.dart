import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'LogEntryForm/LogEntryForm.dart';
import 'Profile/Profile.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Login with Facebook"),
        ),
      ),
    );
  }
}
