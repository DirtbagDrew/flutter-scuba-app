import 'package:flutter/material.dart';
import 'package:scuba/src/LoginRegister/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/LogEntryForm/LogEntryForm.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'http://192.168.254.15:4000/graphql',
    );

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
  bool _verified = false;
  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSharedPreferences(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // //clear shared preferences
            // SharedPreferences pref = snapshot.data;
            // pref.clear();

            if (snapshot.data.getString('id') != null || _verified) {
              return LogEntryForm();
            } else {
              return Login(
                idResult: (String result) {
                  setState(() {
                    _verified = true;
                  });
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
