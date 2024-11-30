import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I should see a list of articles
Future<void> iShouldSeeAListOfArticles(WidgetTester tester) async {
  final articleTile = find.byType(ArticleTile);
  expect(articleTile, findsNWidgets(2));
}
