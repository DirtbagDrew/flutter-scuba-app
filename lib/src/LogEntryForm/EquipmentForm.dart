import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/Units.dart';

class EquipmentForm extends StatelessWidget {
  const EquipmentForm(
      {Key key,
      @required this.autoValidate,
      @required this.formKey,
      @required this.weightUnitsResult,
      @required this.pressureUnitsResult})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  final ValueChanged<String> weightUnitsResult;
  final ValueChanged<String> pressureUnitsResult;

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
        Text(
          'Equipment',
          style: Theme.of(context).textTheme.subhead,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: _decoration('Weight'),
                validator: FormValidators.weight,
              ),
            ),
            _weightUnitsField(),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: TextFormField(
                  decoration: _decoration('Starting Air'),
                  validator: FormValidators.startingAir,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: TextFormField(
                  decoration: _decoration('Ending Air'),
                  validator: FormValidators.endingAir,
                ),
              ),
            ),
          ],
        ),
        _pressureUnitsField(),
      ]),
    );
  }

  Widget _pressureUnitsField() {
    return FormField<String>(
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
