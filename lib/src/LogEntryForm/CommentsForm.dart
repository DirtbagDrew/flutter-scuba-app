import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';

class CommentsForm extends StatefulWidget {
  const CommentsForm(
      {Key key, @required this.formKey, @required this.autoValidate})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool autoValidate;

  @override
  _CommentsFormState createState() => _CommentsFormState();
}

class _CommentsFormState extends State<CommentsForm> {
  _decoration(String s) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: s,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: widget.autoValidate,
      key: widget.formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: TextFormField(
              decoration: _decoration('Comments'),
              validator: FormValidators.comments),
        ),
      ]),
    );
  }
}
