import 'package:flutter_test/flutter_test.dart';

/// Usage: I submit the search query
Future<void> iSubmitTheSearchQuery(WidgetTester tester) async {
  await tester.testTextInput.receiveAction(TextInputAction.search);
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 3));
}
