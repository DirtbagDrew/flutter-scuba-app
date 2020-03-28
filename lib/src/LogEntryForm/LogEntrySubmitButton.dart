import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scuba/models/LogEntryFormData.dart';

class LogEntrySubmitButton extends StatelessWidget {
  const LogEntrySubmitButton({
    Key key,
    @required this.logEntryData,
    @required this.userId,
    @required this.buttonPressed,
  }) : super(key: key);

  final LogEntryData logEntryData;
  final String userId;
  final ValueChanged buttonPressed;

  @override
  Widget build(BuildContext context) {
    String addLogEntry = """
    mutation addNewLogEntry(\$logEntry: LogEntryInput!){
      newLogEntry(logEntry:\$logEntry){
        code
        developerMessage
      }
    }
    """;

    return Mutation(
      options: MutationOptions(
          documentNode: gql(addLogEntry),
          update: (Cache cache, QueryResult result) {
            return cache;
          },
          onCompleted: (result) {
            print(result);
          }),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return RaisedButton(
          onPressed: () {
            buttonPressed(true);
            if (logEntryData.comments != null) {
              _submitLogEntry(context, runMutation);
            }
          },
          child: Text('Submit'),
        );
      },
    );
  }

  void _submitLogEntry(BuildContext context, RunMutation runMutation) {
    runMutation({
      "logEntry": {
        "airTemp": {
          "measurement": logEntryData.airTemp.measurement,
          "units": logEntryData.airTemp.units
        },
        "bottomTemp": {
          "measurement": logEntryData.bottomTemp.measurement,
          "units": logEntryData.bottomTemp.units
        },
        "date": logEntryData.date.toString(),
        "endAir": {
          "measurement": logEntryData.endAir.measurement,
          "units": logEntryData.endAir.units
        },
        "endTime": logEntryData.endTime.format(context).toString(),
        "location": logEntryData.location,
        "locationName": logEntryData.locationName,
        "startAir": {
          "units": logEntryData.startAir.units,
          "measurement": logEntryData.startAir.measurement
        },
        "startTime": logEntryData.startTime.format(context).toString(),
        "surfaceTemp": {
          "measurement": logEntryData.surfaceTemp.measurement,
          "units": logEntryData.surfaceTemp.units
        },
        "title": logEntryData.title,
        "userId": userId,
        "visibility": {
          "measurement": logEntryData.visibility.measurement,
          "units": logEntryData.visibility.units
        },
        "weight": {
          "measurement": logEntryData.weight.measurement,
          "units": logEntryData.weight.units
        },
        "comments": logEntryData.comments
      }
    });
  }
}
