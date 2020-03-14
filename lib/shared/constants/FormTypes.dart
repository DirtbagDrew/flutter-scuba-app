import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NumberTextFormField extends StatelessWidget {
  const NumberTextFormField({
    Key key,
    @required this.validator,
    @required this.decoration,
    @required this.onSaved,
  }) : super(key: key);

  final String Function(String) validator;
  final InputDecoration decoration;
  final void Function(String) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: decoration,
        validator: this.validator,
        onSaved: onSaved,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ]);
  }
}
