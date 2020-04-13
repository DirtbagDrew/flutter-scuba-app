import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/AuthService.dart';
import 'package:scuba/src/LoginRegister/Login.dart';


class LogOutButton extends StatelessWidget {
  const LogOutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    
    _logout() async {
      await _auth.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }

    return RaisedButton(
      child: Text('Log Out'),
      onPressed: () {
        _logout();
      },
    );
  }
}
