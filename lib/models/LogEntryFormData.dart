import 'package:flutter/material.dart';

class LogEntryData {
  DateTime date;
  Reading airTemp;
  Reading bottomTemp;
  Reading endAir;
  Reading startAir;
  Reading surfaceTemp;
  Reading visibility;
  Reading weight;
  String comments;
  String location;
  String locationName;
  String title;
  TimeOfDay endTime;
  TimeOfDay startTime;

  LogEntryData() {
    airTemp = Reading();
    bottomTemp = Reading();
    endAir = Reading();
    startAir = Reading();
    surfaceTemp = Reading();
    visibility = Reading();
    weight = Reading();
  }

  LogEntryData.fromMap(Map<dynamic, dynamic> logEntryMap) {
    date = logEntryMap['date'];
    airTemp = Reading.from(logEntryMap['airTemp'], logEntryMap['airTempUnits']);
    bottomTemp =
        Reading.from(logEntryMap['bottomTemp'], logEntryMap['bottomTempUnits']);
    endAir = Reading.from(logEntryMap['endAir'], logEntryMap['endAirUnits']);
    startAir =
        Reading.from(logEntryMap['startAir'], logEntryMap['startAirUnits']);
    surfaceTemp = Reading.from(
        logEntryMap['surfaceTemp'], logEntryMap['surfaceTempUnits']);
    visibility =
        Reading.from(logEntryMap['visibility'], logEntryMap['visibilityUnits']);
    weight = Reading.from(logEntryMap['weight'], logEntryMap['weightUnits']);
    location = logEntryMap['location'];
    locationName = logEntryMap['locationName'];
    title = logEntryMap['title'];
    endTime = logEntryMap['endTime'];
    startTime = logEntryMap['startTime'];
  }
}

class Reading {
  int measurement;
  String units;

  Reading() {
    measurement = 0;
    units = "";
  }

  Reading.from(int m, String u) {
    measurement = m;
    units = u;
  }
}
