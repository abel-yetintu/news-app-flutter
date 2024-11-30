import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I am on the search page
Future<void> iAmOnTheSearchPage(WidgetTester tester) async {
  await tester.tap(find.byType(NavigationDestination).at(1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 3));
}
