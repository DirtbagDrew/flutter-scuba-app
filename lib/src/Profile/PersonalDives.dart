import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/Conversions.dart';

class PersonalDives extends StatelessWidget {
  const PersonalDives({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          height: 200,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Super fun dive with Heather!",
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Date: "),
                        Text(Conversions.dateTimeToString(DateTime.now()))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Dive Spot: "),
                        Text("Divers Cove, Laguna Beach, CA")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Duration: "),
                        Text("45 minutes")
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Super fun dive with Heather!",
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Date: "),
                        Text(Conversions.dateTimeToString(DateTime.now()))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Dive Spot: "),
                        Text("Divers Cove, Laguna Beach, CA")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Duration: "),
                        Text("45 minutes")
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Super fun dive with Heather!",
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Date: "),
                        Text(Conversions.dateTimeToString(DateTime.now()))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Dive Spot: "),
                        Text("Divers Cove, Laguna Beach, CA")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Duration: "),
                        Text("45 minutes")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
