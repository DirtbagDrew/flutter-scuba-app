import 'package:flutter/material.dart';
import 'package:scuba/src/Home.dart';
import 'package:scuba/src/Login.dart';
import 'package:scuba/src/Profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/LogEntryForm/LogEntryForm.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'http://192.168.254.44:4000/graphql',
    );

    // final AuthLink authLink = AuthLink(
    //   getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    //   // OR
    //   // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // );

    // final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: NormalizedInMemoryCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
        client: client,
        child: CacheProvider(
          child: MaterialApp(
            title: 'Dive Log',
            theme: ThemeData(
                primaryColor: Color(0xff03a9f4),
                accentColor: Color(0xffffd600)),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String id;

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    String getUser = """
        query getUser(\$userId: String!){
  user(userId:\$userId){
    user_id
    username
  }
}
    """;
    return Query(
      options: QueryOptions(
        documentNode: gql(getUser), // this is the query string you just created
        variables: {
          'userId': 'heather',
        },
        pollInterval: 10,
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        // it can be either Map or List
        Map user = result.data.data['user'];

        return Column(
          children: <Widget>[Text(user['username']), Text(user['user_id'])],
        );
      },
    );
    // return FutureBuilder(
    //     future: _getSharedPreferences(),
    //     builder: (context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         if (snapshot.data.getString('id') != null || id != null) {
    //           return Home();
    //         } else {
    //           return Login(
    //             idResult: (String result) {
    //               setState(() {
    //                 id = result;
    //               });
    //             },
    //           );
    //         }
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     });
  }
}
