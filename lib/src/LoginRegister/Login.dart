import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:scuba/models/FacebookProfile.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key key, @required this.idResult}) : super(key: key);

  final ValueChanged<String> idResult;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FacebookProfile _facebookProfile;

  void _setInSharedPreferences(String item, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(item, value);
  }

  void onFacebookLoggedIn(String id) {
    _setInSharedPreferences('id', id);
    widget.idResult(id);
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
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
                  user_id
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
                            onFacebookLoggedIn(user['user_id']);
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
                          onFacebookLoggedIn('F' + _facebookProfile.id);
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
