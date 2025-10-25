// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:integration_package/GraphQLConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  GraphQLConfiguration graphQLConfiguration = await setupGraphQl();
  runApp(MyApp(graphQLConfiguration.client));
}

Future<GraphQLConfiguration> setupGraphQl() async {
  // const serviceUri =
  // 'https://o6uj5ktn85.execute-api.ap-south-1.amazonaws.com/qa/';
  // const serviceUri = 'http://localhost:4000/';
  // const serviceUri = 'https://8a7bc2-3.myshopify.com/api/2023-07/graphql.json';
  const serviceUri =
      'https://idaa-apparels.myshopify.com/api/2023-07/graphql.json';
  // 'https://prjyszpexb.execute-api.ap-south-1.amazonaws.com/prod/';
  // const serviceUri =
  // 'https://prjyszpexb.execute-api.ap-south-1.amazonaws.com/qa/';
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration.config();
  await graphQLConfiguration.initiateGraphQl();
  return graphQLConfiguration;
}

class MyApp extends StatelessWidget {
  ValueNotifier<GraphQLClient>? _graphQlClient;
  MyApp(ValueNotifier<GraphQLClient> valueNotifierclient) {
    _graphQlClient = valueNotifierclient;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: _graphQlClient,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    getSettings();
  }

  Future getSettings() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text('$_counter'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
