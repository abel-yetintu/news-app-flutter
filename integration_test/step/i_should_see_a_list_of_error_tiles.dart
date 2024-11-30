import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I should see a list of error tiles
Future<void> iShouldSeeAListOfErrorTiles(WidgetTester tester) async {
  final listView = find.byKey(const Key('error_listView'));

  expect(listView, findsOneWidget);
}
