import 'package:bloc_test/bloc_test.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/entities/source_entity.dart';
import 'package:echo/features/articles/presentation/bloc/search_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/search_event.dart';
import 'package:echo/features/articles/presentation/bloc/search_state.dart';
import 'package:echo/features/articles/presentation/screens/search_screen.dart';
import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState> implements SearchBloc {}

void main() {
  group(
    'SearchScreen -',
    () {
      late SearchBloc mockSearchBloc;

      setUp(() {
        mockSearchBloc = MockSearchBloc();
      });

      testWidgets(
        'TextField should be present',
        (tester) async {
          when(() => mockSearchBloc.state).thenReturn(SearchInitial());

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: mockSearchBloc,
                child: const Scaffold(
                  body: SafeArea(
                    child: SearchScreen(),
                  ),
                ),
              ),
            ),
          );

          final textField = find.byType(TextField);

          expect(textField, findsOneWidget);
        },
      );

      testWidgets(
        "when state is SearchInitial should show 'Search for topics you're interested in.' text",
        (tester) async {
          when(() => mockSearchBloc.state).thenReturn(SearchInitial());

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: mockSearchBloc,
                child: const Scaffold(
                  body: SafeArea(
                    child: SearchScreen(),
                  ),
                ),
              ),
            ),
          );

          final text = find.text("Search for topics you're interested in.");

          expect(text, findsOneWidget);
        },
      );

      testWidgets(
        "when state is SearchLoading should show a list view with items each containing shimmer widget",
        (tester) async {
          when(() => mockSearchBloc.state).thenReturn(SearchLoading());

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: mockSearchBloc,
                child: const Scaffold(
                  body: SafeArea(
                    child: SearchScreen(),
                  ),
                ),
              ),
            ),
          );

          final listView = find.byType(ListView);
          final shimmer = find.byType(Shimmer);

          expect(listView, findsOneWidget);

          expect(shimmer, findsAtLeast(3));
        },
      );

      testWidgets(
        "when state is SearchFetched should show a list view containing ArticleTiles",
        (tester) async {
          final mockArticles = [
            ArticleEntity(
              title: 'title',
              description: 'description',
              content: 'content',
              url: 'url',
              imageUrl: 'imageUrl',
              publishedAt: DateTime.now(),
              source: const SourceEntity(name: 'name', url: 'url'),
            ),
            ArticleEntity(
              title: 'title',
              description: 'description',
              content: 'content',
              url: 'url',
              imageUrl: 'imageUrl',
              publishedAt: DateTime.now(),
              source: const SourceEntity(name: 'name', url: 'url'),
            ),
          ];

          when(() => mockSearchBloc.state).thenReturn(SearchFetched(query: 'query', articles: mockArticles));

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: mockSearchBloc,
                child: const Scaffold(
                  body: SafeArea(
                    child: SearchScreen(),
                  ),
                ),
              ),
            ),
          );

          final textField = find.byType(TextField);
          await tester.enterText(textField, 'query');
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();

          final listView = find.byType(ListView);
          final articleTiles = find.byType(ArticleTile);

          expect(listView, findsOneWidget);

          expect(articleTiles, findsNWidgets(2));
        },
      );

      testWidgets(
        "when state is SearchFailed should show a list view containing error tiles",
        (tester) async {
          when(() => mockSearchBloc.state).thenReturn(SearchFailed(message: 'Error Message'));

          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: mockSearchBloc,
                child: const Scaffold(
                  body: SafeArea(
                    child: SearchScreen(),
                  ),
                ),
              ),
            ),
          );

          final textField = find.byType(TextField);
          await tester.enterText(textField, 'query');
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();

          final listView = find.byKey(const Key('error_listView'));

          expect(listView, findsOneWidget);
        },
      );
    },
  );
}
