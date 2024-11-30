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

  final mockArticlesResponse = {
    "totalArticles": 2,
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

  setUpAll(() async {
    await initSL();
    sl.unregister<Dio>();
    sl.registerLazySingleton<Dio>(() => mockDioClient);
  });

  group(
    'Integration test',
    () {
      group(
        'search feature',
        () {
          testWidgets(
            'verify searching for articles with successful response',
            (tester) async {
              when(() => mockDioClient.get(any())).thenAnswer((invocaiton) async {
                await Future.delayed(const Duration(seconds: 2));
                return Response(requestOptions: RequestOptions(), data: mockArticlesResponse, statusCode: 200);
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

          testWidgets(
            'verify search for articles when an error occurs',
            (tester) async {
              when(
                () => mockDioClient.get(any()),
              ).thenThrow(
                DioException(requestOptions: RequestOptions()),
              );

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

              final articlesListView = find.byKey(const Key('error_listView'));
              expect(articlesListView, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
