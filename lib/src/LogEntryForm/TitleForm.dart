import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';

class TitleForm extends StatelessWidget {
  const TitleForm(
      {Key key,
      @required this.formKey,
      @required this.autoValidate,
      @required this.titleResult})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  final ValueChanged<String> titleResult;

  _decoration(String s) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: s,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidate: autoValidate,
        key: formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              decoration: _decoration('Title'),
              validator: FormValidators.title,
              onSaved: (result) {
                titleResult(result);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
