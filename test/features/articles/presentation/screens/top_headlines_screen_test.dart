import 'package:bloc_test/bloc_test.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/entities/source_entity.dart';
import 'package:echo/features/articles/presentation/bloc/category_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/top_headlines_bloc.dart';
import 'package:echo/features/articles/presentation/screens/top_headlines_screen.dart';
import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

class MockCategoryBlock extends MockBloc<CategoryEvent, NewsCategory> implements CategoryBloc {}

class MockTopHeadlinesBlock extends MockBloc<TopHeadlinesEvent, TopHeadlinesState> implements TopHeadlinesBloc {}

void main() {
  group(
    'Top Headlines Screen',
    () {
      late CategoryBloc categoryBloc;
      late TopHeadlinesBloc topHeadlinesBloc;

      setUp(() {
        categoryBloc = MockCategoryBlock();
        topHeadlinesBloc = MockTopHeadlinesBlock();
      });

      testWidgets(
        'when state is TopHeadlinesInitial should show an empty container',
        (tester) async {
          when(() => categoryBloc.state).thenReturn(NewsCategory.general);
          when(() => topHeadlinesBloc.state).thenReturn(TopHeadlinesInitial());

          await tester.pumpWidget(
            MaterialApp(
              home: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: categoryBloc,
                  ),
                  BlocProvider.value(
                    value: topHeadlinesBloc,
                  ),
                ],
                child: const Scaffold(
                  body: SafeArea(
                    child: TopHeadlinesScreen(),
                  ),
                ),
              ),
            ),
          );

          final emptyContainer = find.byKey(const Key('_emptyContainer'));

          expect(emptyContainer, findsOneWidget);
        },
      );

      testWidgets(
        'when the state is TopHeadlinesLoading should show a list view with 7 items each containing 3 shimmer widget',
        (tester) async {
          when(() => categoryBloc.state).thenReturn(NewsCategory.general);
          when(() => topHeadlinesBloc.state).thenReturn(TopHeadlinesLoading());

          await tester.pumpWidget(
            MaterialApp(
              home: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: categoryBloc,
                  ),
                  BlocProvider.value(
                    value: topHeadlinesBloc,
                  ),
                ],
                child: const Scaffold(
                  body: SafeArea(
                    child: TopHeadlinesScreen(),
                  ),
                ),
              ),
            ),
          );

          final listView = find.byType(ListView);
          final shimmerWidget = find.byType(Shimmer);

          expect(listView, findsOneWidget);
          expect(shimmerWidget, findsNWidgets(21));
        },
      );

      testWidgets(
        'when state is TopHeadlinesFetched should show a list view containing ArticleTiles',
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

          when(() => categoryBloc.state).thenReturn(NewsCategory.general);
          when(() => topHeadlinesBloc.state).thenReturn(TopHeadlinesFetched(articles: mockArticles));

          await tester.pumpWidget(
            MaterialApp(
              home: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: categoryBloc,
                  ),
                  BlocProvider.value(
                    value: topHeadlinesBloc,
                  ),
                ],
                child: const Scaffold(
                  body: SafeArea(
                    child: TopHeadlinesScreen(),
                  ),
                ),
              ),
            ),
          );

          final listView = find.byType(ListView);
          final articleTile = find.byType(ArticleTile);

          expect(listView, findsOne);
          expect(articleTile, findsNWidgets(2));
        },
      );

      testWidgets(
        'when state is TopHeadlinesError should show a list view containg 7 items of Row',
        (tester) async {
          when(() => topHeadlinesBloc.state).thenReturn(TopHeadlinesError(message: 'Invalid request'));
          when(() => categoryBloc.state).thenReturn(NewsCategory.general);

          await tester.pumpWidget(
            MaterialApp(
              home: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: categoryBloc,
                  ),
                  BlocProvider.value(
                    value: topHeadlinesBloc,
                  ),
                ],
                child: const Scaffold(
                  body: SafeArea(
                    child: TopHeadlinesScreen(),
                  ),
                ),
              ),
            ),
          );

          final listView = find.byKey(const Key('error_listView'));

          expect(listView, findsOneWidget);
        },
      );
    },
  );
}
