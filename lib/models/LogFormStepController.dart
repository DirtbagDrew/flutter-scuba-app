import 'package:flutter/material.dart';

class LogFormStepController {
  bool autoValidate;
  GlobalKey<FormState> formKey;
  StepState state;

  LogFormStepController() {
    autoValidate = false;
    formKey = GlobalKey<FormState>();
    state = StepState.indexed;
  }
}
