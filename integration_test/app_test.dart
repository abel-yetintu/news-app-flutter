import 'package:dio/dio.dart';
import 'package:echo/core/dependecy_injection.dart';
import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:echo/main.dart' as app;
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final mockDioClient = MockDioClient();

  setUpAll(() {
    sl.registerLazySingleton<Dio>(() => mockDioClient);
  });

  group(
    'Integration test',
    () {
      testWidgets(
        'search for articles flow',
        (tester) async {
          final mockResponse = {
            "totalArticles": 1,
            "articles": [
              {
                "title": "Titile",
                "description": "Description",
                "content": "Content",
                "url": "Url",
                "image": "image",
                "publishedAt": "2024-11-19T10:00:03Z",
                "source": {"name": "name", "url": "url"}
              },
              {
                "title": "Titile",
                "description": "Description",
                "content": "Content",
                "url": "Url",
                "image": "image",
                "publishedAt": "2024-11-19T10:00:03Z",
                "source": {"name": "name", "url": "url"}
              }
            ]
          };

          when(() => mockDioClient.get(any())).thenAnswer((invocaiton) async {
            await Future.delayed(const Duration(seconds: 2));
            return Response(requestOptions: RequestOptions(), data: mockResponse, statusCode: 200);
          });

          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          // tap on search on navigation menu
          await tester.tap(find.byType(NavigationDestination).at(1));
          await tester.pumpAndSettle();

          // enter text in search text field
          await tester.enterText(find.byType(TextField), 'search query');
          await tester.pumpAndSettle();

          // tap the search input action
          await tester.testTextInput.receiveAction(TextInputAction.search);
          await tester.pumpAndSettle();

          final articlesListView = find.byType(ListView);
          expect(articlesListView, findsOneWidget);

          final articleTile = find.byType(ArticleTile);
          expect(articleTile, findsNWidgets(2));
        },
      );
    },
  );
}
