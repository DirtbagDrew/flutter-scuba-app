import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Conversions {
  static TimeOfDay timeStringToTimeOfDay(String timeString) {
    RegExp numbersOnly = RegExp(r'[0-9]+');
    var splitString = timeString
        .split(':')
        .map((String s) => numbersOnly.firstMatch(s).group(0))
        .toList();
    var isPM = RegExp(r'([A-Z])\w+').firstMatch(timeString).group(0) == 'PM';

    return TimeOfDay(
        hour: int.parse(splitString[0]) + (isPM ? 12 : 0),
        minute: int.parse(splitString[1]));
  }

  static DateTime dateStringToDateTime(String dateString) {
    List<String> splitDateString = dateString.split('/');
    int year = int.parse(splitDateString[2]);
    int month = int.parse(splitDateString[0]);
    int day = int.parse(splitDateString[1]);
    return DateTime.utc(year, month, day);
  }

  static int minutesBetweenTimeString(
      String startTimeString, String endTimeString) {
    var startSplitString = startTimeString.split(':');
    var endSplitString = endTimeString.split(':');
    var hourDiff =
        int.parse(endSplitString[0]) - int.parse(startSplitString[0]);
    var minDiff = int.parse(endSplitString[1]) - int.parse(startSplitString[1]);
    return hourDiff * 60 + minDiff;
  }

  static int timeOfDayToInt(TimeOfDay timeOfDay) {
    return timeOfDay.hour * 60 + timeOfDay.minute;
  }

  static String dateTimeToString(DateTime date) {
    return DateFormat("MM/dd/yyyy").format(date);
  }

  static String dateFromDBFormat(String dbDate) {
    return dateTimeToString(
        DateTime.fromMicrosecondsSinceEpoch(int.parse(dbDate) * 1000));
  }

  static String timeStringFromDBFormat(String dbTime) {
    var list = dbTime.split(':');
    var hour = int.parse(list[0]) > 12 ? int.parse(list[0]) - 12 : list[0];
    var isPM = int.parse(dbTime[0]) > 11;
    return '$hour:${list[1]}${isPM ? 'PM' : 'AM'}';
  }

  static String shortHandTemp(String longTemp) {
    var shortTemp = 'F';
    if (longTemp == 'Celcius') {
      shortTemp = 'C';
    }
    return shortTemp;
  }
}
