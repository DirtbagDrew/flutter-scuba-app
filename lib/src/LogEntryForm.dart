import 'dart:developer';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../shared/FormValidators.dart';
import '../shared/constants/Units.dart';

class LogEntryForm extends StatefulWidget {
  const LogEntryForm({Key key}) : super(key: key);

  @override
  _LogEntryFormState createState() => _LogEntryFormState();
}

class _LogEntryFormState extends State<LogEntryForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  String _airTempUnits = TempUnits.f;
  String _surfaceTempUnits = TempUnits.f;
  String _bottomTempUnits = TempUnits.f;
  String _pressureUnits = PressureUnits.psi;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  String _visibilityUnits = LengthUnits.ft;
  String _weightUnits = WeightUnits.lbs;
  bool _autoValidate = false;

  _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    setState(() {
      if (date != null) {
        _date = date;
        _dateController.text = DateFormat("MM/dd/yyyy").format(_date);
      }
    });
  }

  _selectTime(String point) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      if (time != null) {
        if (point == PointInDive.start) {
          _startTime = time;
          _startController.text = time.format(context).toString();
        } else {
          _endTime = time;
          _endController.text = time.format(context).toString();
        }
      }
    });
  }

  _decoration(String s) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: s,
    );
  }

  _validateInputs() {
    if (_formKey.currentState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        autovalidate: _autoValidate,
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'New Entry',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Text(
            'Time and Date',
            style: Theme.of(context).textTheme.subhead,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.calendar_today),
                  label: Text('date'),
                  onPressed: _selectDate,
                ),
                Expanded(
                  child: TextFormField(
                    onTap: _selectDate,
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    validator: FormValidators.date,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.timer),
                  label: Text('start'),
                  onPressed: () {
                    _selectTime(PointInDive.start);
                  },
                ),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      _selectTime(PointInDive.start);
                    },
                    controller: _startController,
                    readOnly: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    validator: FormValidators.start,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.timer),
                  label: Text('end'),
                  onPressed: () {
                    _selectTime(PointInDive.stop);
                  },
                ),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      _selectTime(PointInDive.stop);
                    },
                    controller: _endController,
                    readOnly: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    validator: FormValidators.end,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Dive Spot',
            style: Theme.of(context).textTheme.subhead,
          ),
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
          Text(
            'Conditions',
            style: Theme.of(context).textTheme.subhead,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: _decoration('Visibility'),
                  validator: FormValidators.visibility,
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 35,
                    width: 115,
                    child: RadioListTile(
                      value: LengthUnits.ft,
                      groupValue: _visibilityUnits,
                      title: Text('ft'),
                      onChanged: (String value) {
                        setState(() {
                          _visibilityUnits = value;
                        });
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
                        setState(() {
                          _visibilityUnits = value;
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
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 35,
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
            ],
          ),
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
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 35,
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
                decoration: _decoration('Comments'),
                validator: FormValidators.comments),
          ),
          RaisedButton(
            onPressed: _validateInputs,
            child: Text('Submit'),
          )
        ]),
      ),
    );
  }
}
