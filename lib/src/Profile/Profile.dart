import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scuba/shared/FormValidators.dart';
import 'package:scuba/src/Profile/Bio.dart';
import 'package:scuba/src/Profile/PersonalCertifications.dart';
import 'package:scuba/src/Profile/PersonalDives.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({Key key, this.userName}) : super(key: key);

  final String userName;

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  _logout() {
    var pref = _getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSharedPreferences(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.getString('id') != null) {
          String getUser = """
            query getUser(\$userId: String!){
              user(userId:\$userId){
                userId
                firstName
                lastName
              }
            }
            """;
          return Query(
              options: QueryOptions(
                documentNode:
                    gql(getUser), // this is the query string you just created
                variables: {
                  'userId': snapshot.data.getString('id'),
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
                if (user == null) {
                  snapshot.data.clear();
                  return CircularProgressIndicator();
                } else {
                  return SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Bio(
                          firstName: user['firstName'],
                          lastName: user['lastName']),
                      PersonalCertifications(),
                      PersonalDives(),
                    ]),
                  );
                }
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
