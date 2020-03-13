import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/Units.dart';

class EquipmentForm extends StatefulWidget {
  const EquipmentForm(
      {Key key, @required this.autoValidate, @required this.formKey})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final bool autoValidate;

  @override
  _EquipmentFormState createState() => _EquipmentFormState();
}

class _EquipmentFormState extends State<EquipmentForm> {
  String _pressureUnits = PressureUnits.psi;
  String _weightUnits = WeightUnits.lbs;

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
            Column(
              children: <Widget>[
                SizedBox(
                  height: 35,
                  width: 115,
                  child: RadioListTile(
                    value: WeightUnits.lbs,
                    groupValue: _weightUnits,
                    title: Text('lbs'),
                    onChanged: (String value) {
                      setState(() {
                        _weightUnits = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 115,
                  child: RadioListTile(
                    title: Text('kg'),
                    value: WeightUnits.kg,
                    groupValue: _weightUnits,
                    onChanged: (String value) {
                      setState(() {
                        _weightUnits = value;
                      });
                    },
                  ),
                ),
              ],
            )
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
        Row(
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                value: PressureUnits.psi,
                groupValue: _pressureUnits,
                title: Text('psi'),
                onChanged: (String value) {
                  setState(() {
                    _pressureUnits = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 55,
              width: 115,
              child: RadioListTile(
                title: Text('bar'),
                value: PressureUnits.bar,
                groupValue: _pressureUnits,
                onChanged: (String value) {
                  setState(() {
                    _pressureUnits = value;
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
