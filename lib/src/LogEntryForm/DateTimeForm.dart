import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scuba/shared/Conversions.dart';
import 'package:scuba/shared/FormValidators.dart';

class DateTimeForm extends StatelessWidget {
  const DateTimeForm({
    Key key,
    @required this.autoValidate,
    @required this.context,
    @required this.dateResult,
    @required this.endResult,
    @required this.formKey,
    @required this.startResult,
  }) : super(key: key);

  final bool autoValidate;
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final ValueChanged<DateTime> dateResult;
  final ValueChanged<TimeOfDay> endResult;
  final ValueChanged<TimeOfDay> startResult;

  _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      return Conversions.dateTimeToString(date);
    }
    return '';
  }

  _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      return time.format(context).toString();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidate: autoValidate,
        key: formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: _dateField(),
          ),
          _timeField()
        ]),
      ),
    );
  }

  Widget _dateField() {
    return FormField(
      initialValue: TextEditingController(text: ''),
      builder: (FormFieldState<TextEditingController> state) {
        return Row(
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text('date'),
              onPressed: () async {
                TextEditingController dateController = state.value;
                dateController.text = await _selectDate();
                state.didChange(dateController);
              },
            ),
            Expanded(
              child: TextFormField(
                onTap: () async {
                  TextEditingController dateController = state.value;
                  dateController.text = await _selectDate();
                  state.didChange(dateController);
                },
                controller: state.value,
                readOnly: true,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: FormValidators.start,
              ),
            ),
          ],
        );
      },
      onSaved: (TextEditingController result) {
        dateResult(Conversions.dateStringToDateTime(result.text));
      },
    );
  }

  Widget _timeField() {
    return FormField(
      initialValue: <TextEditingController>[
        TextEditingController(text: ''),
        TextEditingController(text: '')
      ],
      builder: (FormFieldState<List<TextEditingController>> state) {
        return Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.timer),
                      label: Text('start'),
                      onPressed: () async {
                        List<TextEditingController> newStateValue = state.value;
                        newStateValue[0].text = await _selectTime();
                        state.didChange(newStateValue);
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          List<TextEditingController> newStateValue =
                              state.value;
                          newStateValue[0].text = await _selectTime();
                          state.didChange(newStateValue);
                        },
                        controller: state.value[0],
                        readOnly: true,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        validator: FormValidators.start,
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.timer),
                      label: Text('end'),
                      onPressed: () async {
                        List<TextEditingController> newStateValue = state.value;
                        newStateValue[1].text = await _selectTime();
                        state.didChange(newStateValue);
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          List<TextEditingController> newStateValue =
                              state.value;
                          newStateValue[1].text = await _selectTime();
                          state.didChange(newStateValue);
                        },
                        controller: state.value[1],
                        readOnly: true,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        validator: FormValidators.end,
                      ),
                    ),
                  ],
                )),
            Text(
              state.errorText != null ? state.errorText : "",
              style: TextStyle(color: Colors.red),
            )
          ],
        );
      },
      validator: (List<TextEditingController> stateValue) {
        if (stateValue[0].text != "" && stateValue[1].text != "") {
          TimeOfDay startTime =
              Conversions.timeStringToTimeOfDay(stateValue[0].text);
          TimeOfDay endTime =
              Conversions.timeStringToTimeOfDay(stateValue[1].text);

          if (Conversions.timeOfDayToInt(startTime) >
              Conversions.timeOfDayToInt(endTime)) {
            return "Invalid end time.";
          }
        }

        return null;
      },
      onSaved: (List<TextEditingController> result) {
        startResult(Conversions.timeStringToTimeOfDay(result[0].text));
        endResult(Conversions.timeStringToTimeOfDay(result[1].text));
      },
    );
  }
}
