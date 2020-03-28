import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scuba/shared/Conversions.dart';
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
          comments     
        }
      }
    """;

    return ScubaLayout(
      automaticallyImplyLeading: true,
      selectedIndex: 1,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Theme(
              data: ThemeData(
                  textTheme: Theme.of(context).textTheme.copyWith(
                        title: TextStyle(fontSize: 32),
                        subtitle: TextStyle(fontSize: 24),
                        headline: TextStyle(fontSize: 20),
                        subhead:
                            TextStyle(fontSize: 14, color: Colors.grey[600]),
                        body1: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                  primaryColor: Color(0xff03a9f4),
                  accentColor: Color(0xffffd600)),
              child: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
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
                              Text(
                                logEntry['title'],
                                style: Theme.of(context).textTheme.title,
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                        text: TextSpan(
                                            text:
                                                logEntry['locationName'] + ', ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle,
                                            children: [
                                          TextSpan(
                                            text: logEntry['location'] + ', ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey[600]),
                                          ),
                                        ])),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  Conversions.dateFromDBFormat(
                                      logEntry['date']),
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Start:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          Conversions.timeStringFromDBFormat(
                                              logEntry['startTime']),
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Duration:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          Conversions.minutesBetweenTimeString(
                                                      logEntry['startTime'],
                                                      logEntry['endTime'])
                                                  .toString() +
                                              ' mins',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Stop:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          Conversions.timeStringFromDBFormat(
                                              logEntry['endTime']),
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Conditions',
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Visibility',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['visibility']['measurement'].toString()} ${logEntry['visibility']['units']}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Air Temp',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['airTemp']['measurement'].toString()}° ${Conversions.shortHandTemp(logEntry['airTemp']['units'])}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Surface Temp',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['surfaceTemp']['measurement'].toString()}° ${Conversions.shortHandTemp(logEntry['surfaceTemp']['units'])}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Bottom Temp',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['bottomTemp']['measurement'].toString()}° ${Conversions.shortHandTemp(logEntry['bottomTemp']['units'])}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Equipment',
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Weight',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['weight']['measurement'].toString()} ${logEntry['weight']['units']}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Start Air',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['startAir']['measurement'].toString()} ${logEntry['startAir']['units']}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'End Air',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Text(
                                          '${logEntry['endAir']['measurement'].toString()} ${logEntry['endAir']['units']}',
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Comments',
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      logEntry['comments'],
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  );
                },
              )),
        ),
      ],
    );
  }
}
