import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
  final ValueChanged<String> dateResult;
  final ValueChanged<String> endResult;
  final ValueChanged<String> startResult;

  _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      return DateFormat("MM/dd/yyyy").format(date);
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
    return Form(
      autovalidate: autoValidate,
      key: formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: _dateField(),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: _startTimeField()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: _endTimeField(),
        ),
      ]),
    );
  }

  Widget _endTimeField() {
    return FormField(
      initialValue: TextEditingController(text: ''),
      builder: (FormFieldState<TextEditingController> state) {
        return Row(
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.timer),
              label: Text('end'),
              onPressed: () async {
                TextEditingController endController = state.value;
                endController.text = await _selectTime();
                state.didChange(endController);
              },
            ),
            Expanded(
              child: TextFormField(
                onTap: () async {
                  TextEditingController endController = state.value;
                  endController.text = await _selectTime();
                  state.didChange(endController);
                },
                controller: state.value,
                readOnly: true,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: FormValidators.end,
              ),
            ),
          ],
        );
      },
      onSaved: (TextEditingController result) {
        endResult(result.text);
      },
    );
  }

  Widget _startTimeField() {
    return FormField(
      initialValue: TextEditingController(text: ''),
      builder: (FormFieldState<TextEditingController> state) {
        return Row(
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.timer),
              label: Text('start'),
              onPressed: () async {
                TextEditingController startController = state.value;
                startController.text = await _selectTime();
                state.didChange(startController);
              },
            ),
            Expanded(
              child: TextFormField(
                onTap: () async {
                  TextEditingController startController = state.value;
                  startController.text = await _selectTime();
                  state.didChange(startController);
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
        startResult(result.text);
      },
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
              child: TextField(
                onTap: () async {
                  TextEditingController dateController = state.value;
                  dateController.text = await _selectDate();
                  state.didChange(dateController);
                },
                controller: state.value,
                readOnly: true,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ],
        );
      },
      onSaved: (TextEditingController result) {
        dateResult(result.text);
      },
    );
  }
}
