import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scuba/shared/Conversions.dart';

class PersonalDives extends StatelessWidget {
  const PersonalDives({Key key, @required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    String getUserLogEntries = """
    query getUserLogEntries(\$userId:String!){
      logEntries(userId:\$userId){
        title
        date
        locationName
        location
        startTime
        endTime    
      }
    }
    """;

    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dives',
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
          ),
        ),
        Container(
            height: 550,
            child: Query(
                options: QueryOptions(
                  documentNode: gql(
                      getUserLogEntries), // this is the query string you just created
                  variables: {
                    'userId': userId,
                  },
                  pollInterval: 10,
                ),
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List logEntries = result.data['logEntries'];

                  return ListView(children: _logEntries(logEntries, context));
                })),
      ],
    );
  }

  List<Widget> _logEntries(List logEntries, BuildContext context) {
    return logEntries
        .map((logEntry) => ListTile(
              title: Text(
                logEntry['title'],
                style: Theme.of(context).textTheme.subhead,
              ),
              subtitle: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Date: "),
                      Text(Conversions.dateTimeToString(
                          DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(logEntry['date']) * 1000)))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Dive Spot: "),
                      Text(
                          "${logEntry['locationName']}, ${logEntry['location']}")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Duration: "),
                      Text(
                          "${Conversions.minutesBetweenTimeString(logEntry['startTime'], logEntry['endTime'])} minutes")
                    ],
                  )
                ],
              ),
            ))
        .toList();
  }
}
