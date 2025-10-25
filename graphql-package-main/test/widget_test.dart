// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
void main() {
  Future<GraphQLConfiguration> setupGraphQl() async {
    const serviceUri =
        'https://px8qkktl4k.execute-api.ap-south-1.amazonaws.com/qa/';
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration.config();
    await graphQLConfiguration.initiateGraphQl();
    return graphQLConfiguration;
  }

  setUp(() async {
    GraphQLConfiguration graphQLConfiguration = await setupGraphQl();
    ValueNotifier<GraphQLClient>? _graphQlClient;
    _graphQlClient = graphQLConfiguration.client;
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp());

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
