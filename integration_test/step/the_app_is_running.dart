import 'package:flutter_test/flutter_test.dart';
import 'package:echo/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  // await tester.pumpWidget(const Echo());
  // await tester.pumpAndSettle();
  main();
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 3));
}
