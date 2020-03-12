import 'package:flutter/material.dart';

class LogEntryData {
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  Reading airTemp;
  Reading surfaceTemp;
  Reading bottomTemp;
  Reading pressure;
  Reading visibility;
  Reading weight;
}

class Reading {
  int measurement;
  String units;
}
