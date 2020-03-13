import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/Units.dart';

class ConditionsForm extends StatefulWidget {
  const ConditionsForm(
      {Key key,
      @required this.formKey,
      @required this.autoValidate,
      @required this.visibilityUnitsResult,
      @required this.tempUnitsResult})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  final ValueChanged<String> visibilityUnitsResult;
  final ValueChanged<String> tempUnitsResult;

  @override
  _ConditionsFormState createState() => _ConditionsFormState();
}

class _ConditionsFormState extends State<ConditionsForm> {
  String _airTempUnits = TempUnits.f;
  String _surfaceTempUnits = TempUnits.f;
  String _bottomTempUnits = TempUnits.f;

  String _visibilityUnits = LengthUnits.ft;

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
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: _decoration('Visibility'),
                validator: FormValidators.visibility,
              ),
            ),
            FormField(
              builder: (FormFieldState<String> state) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                      width: 115,
                      child: RadioListTile(
                        value: LengthUnits.ft,
                        groupValue: _visibilityUnits,
                        title: Text('ft'),
                        onChanged: (String value) {
                          state.didChange(value);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 115,
                      child: RadioListTile(
                        title: Text('m'),
                        value: LengthUnits.m,
                        groupValue: _visibilityUnits,
                        onChanged: (String value) {
                          state.didChange(value);
                        },
                      ),
                    ),
                  ],
                );
              },
              onSaved: (String result) {
                widget.visibilityUnitsResult(result);
              },
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: TextFormField(
                  decoration: _decoration('Air'),
                  validator: FormValidators.airTemperature,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: TextFormField(
                  decoration: _decoration('Surface'),
                  validator: FormValidators.surfaceTemperature,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: TextFormField(
                  decoration: _decoration('Bottom'),
                  validator: FormValidators.bottomTemperature,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                value: TempUnits.f,
                groupValue: _airTempUnits,
                title: Text('F'),
                onChanged: (String value) {
                  setState(() {
                    _airTempUnits = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                title: Text('C'),
                value: TempUnits.c,
                groupValue: _airTempUnits,
                onChanged: (String value) {
                  setState(() {
                    _airTempUnits = value;
                  });
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}
