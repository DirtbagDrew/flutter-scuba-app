import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/models/LogEntryFormData.dart';
import 'package:scuba/models/LogFormStepController.dart';
import 'package:scuba/src/LogEntryForm/CommentsForm.dart';
import 'package:scuba/src/LogEntryForm/ConditionsForm.dart';
import 'package:scuba/src/LogEntryForm/EquipmentForm.dart';
import 'package:scuba/src/LogEntryForm/LocationForm.dart';
import 'package:scuba/src/LogEntryForm/TitleForm.dart';
import 'DateTimeForm.dart';

class LogEntryForm extends StatefulWidget {
  const LogEntryForm({Key key}) : super(key: key);

  @override
  _LogEntryFormState createState() => _LogEntryFormState();
}

class _LogEntryFormState extends State<LogEntryForm> {
  int _currentStep = 0;
  LogEntryData _logEntryData = LogEntryData();

  List<LogFormStepController> _stepControllers = [
    LogFormStepController(),
    LogFormStepController(),
    LogFormStepController(),
    LogFormStepController(),
    LogFormStepController(),
    LogFormStepController(),
  ];

  void _continue() {
    if (_stepControllers[_currentStep].formKey.currentState.validate()) {
      setState(() {
        _stepControllers[_currentStep].formKey.currentState.save();
        _stepControllers[_currentStep].state = StepState.complete;
      });
      if (_currentStep == _mySteps().length - 1) {
      } else {
        setState(() {
          _currentStep++;
          _stepControllers[_currentStep].state = StepState.editing;
        });
      }
    } else {
      setState(() {
        _stepControllers[_currentStep].autoValidate = true;
        _stepControllers[_currentStep].state = StepState.error;
      });
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _goToStep(int stepNumber) {
    setState(() {
      _currentStep = stepNumber;
    });

    if (_stepControllers[_currentStep].state != StepState.complete) {
      setState(() {
        _stepControllers[_currentStep].state = StepState.editing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'New Log Entry',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
        ),
        Stepper(
          physics: ClampingScrollPhysics(),
          currentStep: _currentStep,
          onStepContinue: _continue,
          onStepTapped: (int stepNumber) {
            _goToStep(stepNumber);
          },
          steps: _mySteps(),
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _currentStep != 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: RaisedButton(
                          onPressed: _back,
                          child: const Text('Back'),
                        ),
                      )
                    : Container(),
                RaisedButton(
                  onPressed: _continue,
                  child: Text(_currentStep == _mySteps().length - 1
                      ? 'submit'
                      : 'Next'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
          title: Text(
            'Title',
          ),
          isActive: _currentStep == 0,
          state: _stepControllers[0].state,
          content: TitleForm(
            autoValidate: _stepControllers[0].autoValidate,
            titleResult: (String result) {
              setState(() {
                _logEntryData.title = result;
              });
            },
            formKey: _stepControllers[0].formKey,
          )),
      Step(
        title: Text(
          'Time and Date',
        ),
        isActive: _currentStep == 1,
        state: _stepControllers[1].state,
        content: DateTimeForm(
          context: context,
          formKey: _stepControllers[1].formKey,
          autoValidate: _stepControllers[1].autoValidate,
          dateResult: (DateTime result) {
            setState(() {
              _logEntryData.date = result;
            });
          },
          startResult: (TimeOfDay result) {
            setState(() {
              _logEntryData.startTime = result;
            });
          },
          endResult: (TimeOfDay result) {
            setState(() {
              _logEntryData.endTime = result;
            });
          },
        ),
      ),
      Step(
        title: Text(
          'Location',
        ),
        isActive: _currentStep == 2,
        state: _stepControllers[2].state,
        content: LocationForm(
          formKey: _stepControllers[2].formKey,
          autoValidate: _stepControllers[2].autoValidate,
          nameResult: (String result) {
            setState(() {
              _logEntryData.locationName = result;
            });
          },
          locationResult: (String result) {
            setState(() {
              _logEntryData.location = result;
            });
          },
        ),
      ),
      Step(
        title: Text(
          'Conditions',
        ),
        isActive: _currentStep == 3,
        state: _stepControllers[3].state,
        content: ConditionsForm(
          formKey: _stepControllers[3].formKey,
          autoValidate: _stepControllers[3].autoValidate,
          airTempResult: (int value) {
            setState(() {
              _logEntryData.airTemp.measurement = value;
            });
          },
          bottomTempResult: (int value) {
            setState(() {
              _logEntryData.bottomTemp.measurement = value;
            });
          },
          surfaceTempResult: (int value) {
            setState(() {
              _logEntryData.surfaceTemp.measurement = value;
            });
          },
          tempUnitsResult: (String value) {
            setState(() {
              _logEntryData.airTemp.units = value;
              _logEntryData.surfaceTemp.units = value;
              _logEntryData.bottomTemp.units = value;
            });
          },
          visibilityResult: (int value) {
            setState(() {
              _logEntryData.visibility.measurement = value;
            });
          },
          visibilityUnitsResult: (String value) {
            setState(() {
              _logEntryData.visibility.units = value;
            });
          },
          context: context,
        ),
      ),
      Step(
          title: Text('Equipment'),
          isActive: _currentStep == 4,
          state: _stepControllers[4].state,
          content: EquipmentForm(
            formKey: _stepControllers[4].formKey,
            autoValidate: _stepControllers[4].autoValidate,
            pressureUnitsResult: (String value) {
              setState(() {
                _logEntryData.weight.units = value;
              });
            },
            weightUnitsResult: (String value) {
              setState(() {
                _logEntryData.weight.units = value;
              });
            },
            endingAirResult: (int value) {
              setState(() {
                _logEntryData.startingAir.measurement = value;
              });
            },
            startingAirResult: (int value) {
              setState(() {
                _logEntryData.endingAir.measurement = value;
              });
            },
            weightResult: (int value) {
              setState(() {
                _logEntryData.weight.measurement = value;
              });
            },
          )),
      Step(
        title: Text(
          'Comments',
        ),
        isActive: _currentStep == 5,
        state: _stepControllers[5].state,
        content: CommentsForm(
          formKey: _stepControllers[5].formKey,
          autoValidate: _stepControllers[5].autoValidate,
          commentsResult: (String value) {
            setState(() {
              _logEntryData.weight.measurement = int.parse(value);
            });
          },
        ),
      ),
    ];
    return _steps;
  }
}
