import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/shared/Conversions.dart';

class PersonalCertifications extends StatelessWidget {
  const PersonalCertifications({
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
                  'Certifications',
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "PADI Open Water",
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Issued: "),
                        Text(Conversions.dateTimeToString(DateTime.now()))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
