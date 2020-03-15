import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Conversions {
  static TimeOfDay timeStringToTimeOfDay(String timeString) {
    RegExp numbersOnly = RegExp(r'[0-9]+');
    var splitString = timeString
        .split(':')
        .map((String s) => numbersOnly.firstMatch(s).group(0))
        .toList();

    return TimeOfDay(
        hour: int.parse(splitString[0]), minute: int.parse(splitString[1]));
  }

  static DateTime dateStringToDateTime(String dateString) {
    List<String> splitDateString = dateString.split('/');
    int year = int.parse(splitDateString[2]);
    int month = int.parse(splitDateString[1]);
    int day = int.parse(splitDateString[0]);
    return DateTime(year, month, day);
  }

  static int timeOfDayToInt(TimeOfDay timeOfDay) {
    return timeOfDay.hour * 60 + timeOfDay.minute;
  }

  static String dateTimeToString(DateTime date) {
    return DateFormat("MM/dd/yyyy").format(date);
  }
}
