import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter {'search term'} into the search bar
Future<void> iEnterIntoTheSearchBar(WidgetTester tester, String searchTerm) async {
  await tester.enterText(find.byType(TextField), searchTerm);
  await Future.delayed(const Duration(seconds: 3));
}
