import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IDGetter extends StatelessWidget {
  const IDGetter({Key key, @required this.child, @required this.idEmitter})
      : super(key: key);

  final Widget child;
  final ValueChanged<String> idEmitter;

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSharedPreferences(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.getString('id') != null) {
          idEmitter(snapshot.data.getString('id'));
          return child;
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
