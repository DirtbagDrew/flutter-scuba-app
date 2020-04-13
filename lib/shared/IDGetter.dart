import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/AuthService.dart';

class IDGetter extends StatelessWidget {
  const IDGetter({Key key, @required this.child, @required this.idEmitter})
      : super(key: key);

  final Widget child;
  final ValueChanged<String> idEmitter;

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    return FutureBuilder(
      future: _auth.getUserId(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != '') {
          idEmitter(snapshot.data);
          return child;
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
