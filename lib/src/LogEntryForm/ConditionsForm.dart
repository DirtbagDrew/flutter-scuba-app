import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/FormTypes.dart';
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
  final ValueChanged<int> airTempResult;
  final ValueChanged<int> bottomTempResult;
  final ValueChanged<int> surfaceTempResult;
  final ValueChanged<int> visibilityResult;
  final ValueChanged<String> tempUnitsResult;
  final ValueChanged<String> visibilityUnitsResult;

  InputDecoration _decoration(String s) {
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
              Text('Temperatures'),
              _tempUnitsField(),
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
        ]),
      ),
    );
  }

  Widget _bottomTempField() {
    return NumberTextFormField(
      decoration: _decoration('Bottom'),
      validator: FormValidators.bottomTemperature,
      onSaved: (String result) {
        bottomTempResult(int.parse(result));
      },
    );
  }

  Widget _surfaceTempField() {
    return NumberTextFormField(
      decoration: _decoration('Surface'),
      validator: FormValidators.surfaceTemperature,
      onSaved: (String result) {
        surfaceTempResult(int.parse(result));
      },
    );
  }

  Widget _tempUnitsField() {
    return FormField(
      initialValue: TempUnits.f,
      builder: (FormFieldState<String> state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 90,
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
              width: 90,
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
    return NumberTextFormField(
      decoration: _decoration('Air'),
      validator: FormValidators.airTemperature,
      onSaved: (String result) {
        airTempResult(int.parse(result));
      },
    );
  }

  Widget visibilityField() {
    return NumberTextFormField(
      decoration: _decoration('Visibility'),
      validator: FormValidators.visibility,
      onSaved: (String result) {
        visibilityResult(int.parse(result));
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
