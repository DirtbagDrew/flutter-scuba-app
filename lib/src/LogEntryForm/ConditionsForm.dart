import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/Units.dart';

class ConditionsForm extends StatelessWidget {
  const ConditionsForm({
    Key key,
    @required this.airTempResult,
    @required this.autoValidate,
    @required this.bottomTempResult,
    @required this.formKey,
    @required this.surfaceTempResult,
    @required this.tempUnitsResult,
    @required this.visibilityResult,
    @required this.visibilityUnitsResult,
  }) : super(key: key);

  final bool autoValidate;
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> airTempResult;
  final ValueChanged<String> bottomTempResult;
  final ValueChanged<String> surfaceTempResult;
  final ValueChanged<String> tempUnitsResult;
  final ValueChanged<String> visibilityResult;
  final ValueChanged<String> visibilityUnitsResult;

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
        Row(
          children: <Widget>[
            Expanded(
              child: visibilityField(),
            ),
            _visibilityUnitsField(),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _airTempField(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: _surfaceTempField(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: _bottomTempField(),
              ),
            ),
          ],
        ),
        _tempUnitsField(),
      ]),
    );
  }

  Widget _bottomTempField() {
    return TextFormField(
      decoration: _decoration('Bottom'),
      validator: FormValidators.bottomTemperature,
      onSaved: (String result) {
        bottomTempResult(result);
      },
    );
  }

  Widget _surfaceTempField() {
    return TextFormField(
      decoration: _decoration('Surface'),
      validator: FormValidators.surfaceTemperature,
      onSaved: (String result) {
        surfaceTempResult(result);
      },
    );
  }

  Widget _tempUnitsField() {
    return FormField(
      builder: (FormFieldState<String> state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                value: TempUnits.f,
                groupValue: state.value,
                title: Text('F'),
                onChanged: (String value) {
                  state.didChange(value);
                },
              ),
            ),
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                title: Text('C'),
                value: TempUnits.c,
                groupValue: state.value,
                onChanged: (String value) {
                  state.didChange(value);
                },
              ),
            ),
          ],
        );
      },
      onSaved: (result) {
        tempUnitsResult(result);
      },
    );
  }

  Widget _airTempField() {
    return TextFormField(
      decoration: _decoration('Air'),
      validator: FormValidators.airTemperature,
      onSaved: (String result) {
        airTempResult(result);
      },
    );
  }

  Widget visibilityField() {
    return TextFormField(
      decoration: _decoration('Visibility'),
      validator: FormValidators.visibility,
      onSaved: (String result) {
        visibilityResult(result);
      },
    );
  }

  Widget _visibilityUnitsField() {
    return FormField(
      initialValue: LengthUnits.ft,
      builder: (FormFieldState<String> state) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 35,
              width: 115,
              child: RadioListTile(
                value: LengthUnits.ft,
                groupValue: state.value,
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
                groupValue: state.value,
                onChanged: (String value) {
                  state.didChange(value);
                },
              ),
            ),
          ],
        );
      },
      onSaved: (String result) {
        visibilityUnitsResult(result);
      },
    );
  }
}
