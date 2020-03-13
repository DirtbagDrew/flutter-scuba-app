import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/shared/constants/Units.dart';

class DateTimeForm extends StatefulWidget {
  const DateTimeForm(
      {Key key, @required this.autoValidate, @required this.formKey})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool autoValidate;

  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    setState(() {
      if (date != null) {
        _dateController.text = DateFormat("MM/dd/yyyy").format(date);
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
          _startController.text = time.format(context).toString();
        } else {
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

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: widget.autoValidate,
      key: widget.formKey,
      child: Column(children: <Widget>[
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
      ]),
    );
  }
}
