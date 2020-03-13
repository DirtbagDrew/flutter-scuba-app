import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';

class LocationForm extends StatelessWidget {
  const LocationForm(
      {Key key,
      @required this.formKey,
      @required this.autoValidate,
      @required this.nameResult,
      @required this.locationResult})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  final ValueChanged<String> nameResult;
  final ValueChanged<String> locationResult;

  _decoration(String s) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: s,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: autoValidate,
      key: formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _nameField(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _locationField(),
        ),
      ]),
    );
  }

  Widget _locationField() {
    return TextFormField(
      decoration: _decoration('Location'),
      validator: FormValidators.location,
      onSaved: (String result) {
        locationResult(result);
      },
    );
  }

  Widget _nameField() {
    return TextFormField(
      decoration: _decoration('Name'),
      validator: FormValidators.name,
      onSaved: (String result) {
        nameResult(result);
      },
    );
  }
}
