import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/FormTypes.dart';
import 'package:scuba/shared/constants/Units.dart';

class EquipmentForm extends StatelessWidget {
  const EquipmentForm({
    Key key,
    @required this.autoValidate,
    @required this.endingAirResult,
    @required this.formKey,
    @required this.pressureUnitsResult,
    @required this.startingAirResult,
    @required this.weightResult,
    @required this.weightUnitsResult,
  }) : super(key: key);
  final bool autoValidate;
  final GlobalKey<FormState> formKey;
  final ValueChanged<int> endingAirResult;
  final ValueChanged<int> startingAirResult;
  final ValueChanged<int> weightResult;
  final ValueChanged<String> pressureUnitsResult;
  final ValueChanged<String> weightUnitsResult;

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
          Text(
            'Equipment',
            style: Theme.of(context).textTheme.subhead,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _weightField(),
              ),
              _weightUnitsField(),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: _startingAirField(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: _endingAirField(),
                ),
              ),
            ],
          ),
          _pressureUnitsField(),
        ]),
      ),
    );
  }

  Widget _endingAirField() {
    return NumberTextFormField(
      decoration: _decoration('Ending Air'),
      validator: FormValidators.endingAir,
      onSaved: (String result) {
        endingAirResult(int.parse(result));
      },
    );
  }

  Widget _startingAirField() {
    return NumberTextFormField(
      decoration: _decoration('Starting Air'),
      validator: FormValidators.startingAir,
      onSaved: (String result) {
        startingAirResult(int.parse(result));
      },
    );
  }

  Widget _weightField() {
    return NumberTextFormField(
      decoration: _decoration('Weight'),
      validator: FormValidators.weight,
      onSaved: (String result) {
        weightResult(int.parse(result));
      },
    );
  }

  Widget _pressureUnitsField() {
    return FormField<String>(
      initialValue: PressureUnits.psi,
      builder: (FormFieldState<String> state) {
        return Row(
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                value: PressureUnits.psi,
                groupValue: state.value,
                title: Text('psi'),
                onChanged: (String value) {
                  state.didChange(value);
                },
              ),
            ),
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                title: Text('bar'),
                value: PressureUnits.bar,
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
        this.pressureUnitsResult(result);
      },
    );
  }

  Widget _weightUnitsField() {
    return FormField<String>(
      initialValue: WeightUnits.lbs,
      builder: (FormFieldState<String> state) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 35,
              width: 115,
              child: RadioListTile(
                value: WeightUnits.lbs,
                groupValue: state.value,
                title: Text('lbs'),
                onChanged: (String value) {
                  state.didChange(value);
                },
              ),
            ),
            SizedBox(
              width: 115,
              child: RadioListTile(
                title: Text('kg'),
                value: WeightUnits.kg,
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
        weightUnitsResult(result);
      },
    );
  }
}
