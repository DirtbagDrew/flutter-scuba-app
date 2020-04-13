import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/models/FacebookProfile.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:scuba/shared/AuthService.dart';
import 'package:scuba/src/LogEntryForm/LogEntryForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService _auth = AuthService();
  FacebookProfile _facebookProfile;

  void onFacebookLoggedIn(String id, BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogEntryForm()),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult = await _auth.login();
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');
      setState(() {
        _facebookProfile = FacebookProfile(json.decode(graphResponse.body));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (_facebookProfile != null) {
            String getUser = """
              query getUser(\$userId: String!){
                user(userId:\$userId){
                  userId
                }
              }
            """;

            return Query(
              options: QueryOptions(
                documentNode:
                    gql(getUser), // this is the query string you just created
                variables: {
                  'userId': 'F' + _facebookProfile.id,
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
                if (user != null) {
                  SchedulerBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            onFacebookLoggedIn(user['userId'], context);
                          }));
                } else {
                  String registerUser = """
                    mutation(
                      \$userId: String!
                      \$firstName: String!
                      \$lastName: String!
                      \$email: String!
                    ) {
                      registerUser(
                        userId: \$userId
                        firstName: \$firstName
                        lastName: \$lastName
                        email: \$email
                      ) {
                        code
                        developerMessage
                      }
                    }
                  """;
                  return Mutation(
                    options: MutationOptions(
                        documentNode: gql(registerUser),
                        update: (Cache cache, QueryResult result) {
                          return cache;
                        },
                        onCompleted: (result) {
                          onFacebookLoggedIn(
                              'F' + _facebookProfile.id, context);
                        }),
                    builder: (
                      RunMutation runMutation,
                      QueryResult result,
                    ) {
                      runMutation({
                        'userId': 'F' + _facebookProfile.id,
                        'firstName': _facebookProfile.firstName,
                        'lastName': _facebookProfile.lastName,
                        'email': _facebookProfile.email
                      });

                      return CircularProgressIndicator();
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            );
          } else {
            return Center(
              child: RaisedButton(
                onPressed: initiateFacebookLogin,
                child: Text("Login with Facebook"),
              ),
            );
          }
        },
      ),
    );
  }
}
