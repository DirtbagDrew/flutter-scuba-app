import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scuba/shared/IDGetter.dart';
import 'package:scuba/src/Profile/Bio.dart';
import 'package:scuba/src/Profile/PersonalCertifications.dart';
import 'package:scuba/src/Profile/PersonalDives.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, this.userName}) : super(key: key);

  final String userName;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String id;

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  _logout() {
    var pref = _getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    String getUser = """
            query getUser(\$userId: String!){
              user(userId:\$userId){
                userId
                firstName
                lastName
              }
            }
            """;

    return IDGetter(
      idEmitter: (result) {
        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
              id = result;
            })); // executes after build
      },
      child: Query(
          options: QueryOptions(
            documentNode:
                gql(getUser), // this is the query string you just created
            variables: {
              'userId': id,
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

            Map user = result.data['user'];

            return SingleChildScrollView(
              child: Column(children: <Widget>[
                // Bio(firstName: user['firstName'], lastName: user['lastName']),
                // PersonalCertifications(),
                PersonalDives(
                  userId: id,
                ),
              ]),
            );
          }),
    );
  }
}
