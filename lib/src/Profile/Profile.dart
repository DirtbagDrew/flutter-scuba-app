import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/src/Profile/Bio.dart';
import 'package:scuba/src/Profile/PersonalDives.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key key,
  }) : super(key: key);

  _decoration(String s) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: s,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Bio(),
        PersonalDives(),
      ]),
    );
  }
}
