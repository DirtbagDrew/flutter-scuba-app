import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bio extends StatelessWidget {
  const Bio({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          children: <Widget>[
            Align(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Andrew Myer",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Text(
              "I am the best scuber duber in the world! Heather is a super duper cool dive buddy",
              style: Theme.of(context).textTheme.subtitle,
            )
          ],
        ),
      ),
    );
  }
}
