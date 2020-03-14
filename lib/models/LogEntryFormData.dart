import 'package:flutter/material.dart';

class LogEntryData {
  DateTime date;
  Reading airTemp;
  Reading bottomTemp;
  Reading endingAir;
  Reading startingAir;
  Reading surfaceTemp;
  Reading visibility;
  Reading weight;
  String location;
  String locationName;
  TimeOfDay endTime;
  TimeOfDay startTime;

  LogEntryData() {
    airTemp = Reading();
    bottomTemp = Reading();
    endingAir = Reading();
    startingAir = Reading();
    surfaceTemp = Reading();
    visibility = Reading();
    weight = Reading();
  }
}

class Reading {
  int measurement;
  String units;
}
