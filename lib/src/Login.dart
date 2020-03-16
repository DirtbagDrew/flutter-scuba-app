import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/models/FacebookProfile.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({Key key, @required this.idResult}) : super(key: key);

  final ValueChanged<String> idResult;

  _getFromSharedPreferences(String item) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(item);
  }

  void _setInSharedPreferences(String item, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(item, value);
  }

  void onLoginStatusChanged(FacebookProfile profileData) {
    _setInSharedPreferences('id', profileData.id);
    idResult(profileData.id);
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');
      var profile = json.decode(graphResponse.body);
      onLoginStatusChanged(FacebookProfile(profile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: initiateFacebookLogin,
          child: Text("Login with Facebook"),
        ),
      ),
    );
  }
}
