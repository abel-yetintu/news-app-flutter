import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:echo/core/dependecy_injection.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/entities/source_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_state.dart';
import 'package:echo/features/articles/presentation/bloc/saved_articles_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchSavedArticlesUsecase extends Mock implements FetchSavedArticlesUseCase {}

class MockAddArticleUsecase extends Mock implements AddArticleUseCase {}

class MockRemoveArticleUsecase extends Mock implements RemoveArticleUseCase {}

void main() {
  group(
    'SavedArticleBloc',
    () {
      late MockFetchSavedArticlesUsecase mockFetchSavedArticlesUsecase;
      late MockAddArticleUsecase mockAddArticleUsecase;
      late MockRemoveArticleUsecase mockRemoveArticleUsecase;
      late SavedArticleBloc savedArticleBloc;
      late ArticleEntity article;

      setUpAll(() async {
        WidgetsFlutterBinding.ensureInitialized();
        await initSL();
        article = ArticleEntity(
          id: 1,
          title: 'title1',
          description: 'description1',
          content: 'content1',
          url: 'url1',
          imageUrl: 'imageUrl1',
          publishedAt: DateTime.now(),
          source: const SourceEntity(name: 'name1', url: 'url1'),
        );
      });

      setUp(() {
        mockFetchSavedArticlesUsecase = MockFetchSavedArticlesUsecase();
        mockAddArticleUsecase = MockAddArticleUsecase();
        mockRemoveArticleUsecase = MockRemoveArticleUsecase();
        savedArticleBloc = SavedArticleBloc(
          addArticleUseCase: mockAddArticleUsecase,
          fetchSavedArticlesUseCase: mockFetchSavedArticlesUsecase,
          removeArticleUseCase: mockRemoveArticleUsecase,
        );
      });

      tearDown(() {
        savedArticleBloc.close();
      });

      test(
        'initial state of SavedArticleBloc should be SavedArticleInitial',
        () {
          expect(savedArticleBloc.state, SavedArticlesInitial());
        },
      );

      blocTest(
        'handles FetchSavedArticles event when successful',
        setUp: () {
          when(
            () => mockFetchSavedArticlesUsecase.execute(),
          ).thenAnswer(
            (_) async => Right([article]),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(FetchSavedArticles()),
        expect: () => [
          SavedArticlesLoading(),
          SavedArticlesFetched(articles: [article])
        ],
      );

      blocTest(
        'handles FetchSavedArticles event when error',
        setUp: () {
          when(
            () => mockFetchSavedArticlesUsecase.execute(),
          ).thenAnswer(
            (_) async => const Left(Failure(message: 'Error Message')),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(FetchSavedArticles()),
        expect: () => [SavedArticlesLoading(), SavedArticlesFailed(message: 'Error Message')],
      );

      blocTest(
        'handles AddArticle event when successful',
        setUp: () {
          when(
            () => mockAddArticleUsecase.execute(article: article),
          ).thenAnswer(
            (_) async => Right(article.id ?? 1),
          );
          when(
            () => mockFetchSavedArticlesUsecase.execute(),
          ).thenAnswer(
            (_) async => Right([article]),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(AddArticle(article: article, reAdd: false)),
        expect: () => [
          SavedArticlesFetched(articles: [article])
        ],
      );

      blocTest(
        'handles AddArticle event when error',
        setUp: () {
          when(
            () => mockAddArticleUsecase.execute(article: article),
          ).thenAnswer(
            (_) async => const Left(Failure(message: 'Error Message')),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(AddArticle(article: article, reAdd: false)),
        expect: () => [],
      );

      blocTest(
        'handles RemoveArticle event when successful',
        setUp: () {
          when(
            () => mockRemoveArticleUsecase.execute(article: article),
          ).thenAnswer(
            (_) async => const Right(1),
          );
          when(
            () => mockFetchSavedArticlesUsecase.execute(),
          ).thenAnswer(
            (_) async => Right([article]),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(RemoveArticle(article: article)),
        expect: () => [
          SavedArticlesFetched(articles: [article])
        ],
      );

      blocTest(
        'handles RemoveArticle event when error',
        setUp: () {
          when(
            () => mockRemoveArticleUsecase.execute(article: article),
          ).thenAnswer(
            (_) async => const Left(Failure(message: 'Error Message')),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(RemoveArticle(article: article)),
        expect: () => [],
      );

      blocTest(
        'handles RefetchSavedArticles event when successful',
        setUp: () {
          when(
            () => mockFetchSavedArticlesUsecase.execute(),
          ).thenAnswer(
            (_) async => Right([article]),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(RefetchSavedArticles()),
        expect: () => [
          SavedArticlesFetched(articles: [article])
        ],
      );

      blocTest(
        'handles RefetchSavedArticles event when error',
        setUp: () {
          when(
            () => mockFetchSavedArticlesUsecase.execute(),
          ).thenAnswer(
            (_) async => const Left(Failure(message: 'Error Message')),
          );
        },
        build: () => savedArticleBloc,
        act: (bloc) => bloc.add(RefetchSavedArticles()),
        expect: () => [SavedArticlesFailed(message: 'Error Message')],
      );
    },
  );
}
