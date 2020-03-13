import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/src/LogEntryForm/CommentsForm.dart';
import 'package:scuba/src/LogEntryForm/ConditionsForm.dart';
import 'package:scuba/src/LogEntryForm/EquipmentForm.dart';
import 'package:scuba/src/LogEntryForm/LocationForm.dart';
import 'LogEntryForm/DateTimeForm.dart';

class LogEntryForm extends StatefulWidget {
  const LogEntryForm({Key key}) : super(key: key);

  @override
  _LogEntryFormState createState() => _LogEntryFormState();
}

class _LogEntryFormState extends State<LogEntryForm> {
  int _currentStep = 0;
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<bool> _autoValidation = [
    false,
    false,
    false,
    false,
    false,
  ];

  _continue() {
    if (_currentStep < _mySteps().length) {
      if (_formKeys[_currentStep].currentState.validate()) {
        setState(() {
          _formKeys[_currentStep].currentState.save();
          _currentStep++;
        });
      } else {
        setState(() {
          _autoValidation[_currentStep] = true;
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: _mySteps(),
      onStepContinue: _continue,
      currentStep: _currentStep,
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text(
          'Time and Date',
        ),
        isActive: _currentStep == 0,
        content: DateTimeForm(
          formKey: _formKeys[0],
          autoValidate: _autoValidation[0],
        ),
      ),
      Step(
        title: Text(
          'Location',
        ),
        isActive: _currentStep == 1,
        content: LocationForm(
          formKey: _formKeys[1],
          autoValidate: _autoValidation[1],
        ),
      ),
      Step(
        title: Text(
          'Conditions',
        ),
        isActive: _currentStep == 2,
        content: ConditionsForm(
          formKey: _formKeys[2],
          autoValidate: _autoValidation[2],
        ),
      ),
      Step(
          title: Text('Equipment'),
          isActive: _currentStep == 3,
          content: EquipmentForm(
            formKey: _formKeys[3],
            autoValidate: _autoValidation[3],
          )),
      Step(
        title: Text(
          'Comments',
        ),
        isActive: _currentStep == 4,
        content: CommentsForm(
          formKey: _formKeys[4],
          autoValidate: _autoValidation[4],
        ),
      ),
    ];
    return _steps;
  }
}
