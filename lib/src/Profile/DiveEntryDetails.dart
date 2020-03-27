import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scuba/shared/ScubaLayout.dart';

class DiveEntryDetails extends StatelessWidget {
  const DiveEntryDetails({Key key, this.logEntryId}) : super(key: key);

  final int logEntryId;

  @override
  Widget build(BuildContext context) {
    String getLogEntry = """
      query getLogEntry(\$id:Int!){
        logEntry(id:\$id){
          airTemp {
            measurement
            units
          }
          bottomTemp {
            measurement
            units
          }
          date
          endAir {
            measurement
            units
          }
          endTime
          location
          locationName
          startAir {
            measurement
            units
          }
          startTime
          surfaceTemp {
            measurement
            units
          }
          title
          visibility {
            measurement
            units
          }
          weight {
            measurement
            units
          }     
        }
      }
    """;

    return ScubaLayout(
      selectedIndex: 1,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Query(
              options: QueryOptions(
                documentNode: gql(
                    getLogEntry), // this is the query string you just created
                variables: {
                  'id': logEntryId,
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

                Map logEntry = result.data['logEntry'];

                return Column(
                  children: <Widget>[
                    Text(logEntry['title']),
                    Text(logEntry['date']),
                    Text(logEntry['startTime']),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
