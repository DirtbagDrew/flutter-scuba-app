import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';

class LocationForm extends StatefulWidget {
  const LocationForm({Key key, this.formKey, this.autoValidate})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool autoValidate;

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
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
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TextFormField(
            decoration: _decoration('Name'),
            validator: FormValidators.name,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TextFormField(
            decoration: _decoration('Location'),
            validator: FormValidators.location,
          ),
        ),
      ]),
    );
  }
}
