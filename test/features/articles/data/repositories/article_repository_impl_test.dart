import 'package:dio/dio.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/data/data_sources/local/article_local_data_source_impl.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source_impl.dart';
import 'package:echo/features/articles/data/models/article_model.dart';
import 'package:echo/features/articles/data/repositories/article_repository_impl.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/entities/source_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleRemoteDataSource extends Mock implements ArticleRemoteDataSourceImpl {}

class MockArticleLocalDataSource extends Mock implements ArticleLocalDataSourceImpl {}

void main() {
  late final ArticleRemoteDataSourceImpl mockArticleRemoteDataSource;
  late final ArticleLocalDataSourceImpl mockArticleLocalDataSource;
  late final ArticleRepositoryImpl articleRepositoryImpl;
  late final ArticleEntity mockArticleEntity;
  late final ArticleModel mockArticleModel;

  setUpAll(
    () {
      // mocking data sources
      mockArticleRemoteDataSource = MockArticleRemoteDataSource();
      mockArticleLocalDataSource = MockArticleLocalDataSource();

      // creatin instance of ArticleRepositoryImpl
      articleRepositoryImpl = ArticleRepositoryImpl(articleRemoteDataSource: mockArticleRemoteDataSource, articleLocalDataSource: mockArticleLocalDataSource);

      // creating mock responses
      mockArticleEntity = ArticleEntity(
        title: 'title',
        description: 'description',
        content: 'content',
        url: 'url',
        imageUrl: 'imageUrl',
        publishedAt: DateTime.now(),
        source: const SourceEntity(name: 'name', url: 'url'),
      );
      mockArticleModel = ArticleModel.fromEntitiy(entity: mockArticleEntity);

      // ArticleModel fallback
      registerFallbackValue(mockArticleModel);
    },
  );

  group(
    'ArticleRepositoryImpl -',
    () {
      group(
        'fetchTopHeadlines function -',
        () {
          test(
            'when fetchTopHeadlines function is called and is a successful response then a list of ArticleEntity should be returned',
            () async {
              when(() {
                return mockArticleRemoteDataSource.getTopHeadlines(newsCategory: NewsCategory.general);
              }).thenAnswer((invocation) async {
                return [mockArticleModel];
              });

              final result = await articleRepositoryImpl.fetchTopHeadlines(newsCategory: NewsCategory.general);

              result.fold(
                (failure) {
                  fail('Test failed - fuction returned Failure');
                },
                (articles) {
                  expect(articles, isA<List<ArticleEntity>>());
                },
              );
            },
          );

          test(
            'when fetchTopHeadlines function is called and exception is thrown then a Failure object should be returned',
            () async {
              when(() {
                return mockArticleRemoteDataSource.getTopHeadlines(newsCategory: NewsCategory.general);
              }).thenThrow(
                (invocation) => DioException(requestOptions: RequestOptions()),
              );

              final result = await articleRepositoryImpl.fetchTopHeadlines(newsCategory: NewsCategory.general);

              result.fold(
                (failure) {
                  expect(failure, isA<Failure>());
                },
                (articles) {
                  fail('Test failed - function returned a list of ArticleEntity');
                },
              );
            },
          );
        },
      );

      group(
        'searchArticles function -',
        () {
          test(
            'when searchArticles function is called and is successful response then a List of ArticleEntity should be returned',
            () async {
              when(
                () => mockArticleRemoteDataSource.searchArticles(query: any(named: 'query')),
              ).thenAnswer(
                (invocation) async {
                  return [mockArticleModel];
                },
              );

              final result = await articleRepositoryImpl.searchArticles(query: 'query');

              result.fold(
                (failure) {
                  fail('Test failred - returned Failure object');
                },
                (articles) {
                  expect(articles, isA<List<ArticleEntity>>());
                },
              );
            },
          );

          test(
            'when searchArticles fucntion is called and exception is thrown then a Failure object should be returned ',
            () async {
              when(
                () => mockArticleRemoteDataSource.searchArticles(query: any(named: 'query')),
              ).thenThrow(
                (invocation) => DioException(requestOptions: RequestOptions()),
              );

              final result = await articleRepositoryImpl.searchArticles(query: 'query');

              result.fold(
                (failure) {
                  expect(failure, isA<Failure>());
                },
                (articles) {
                  fail('Test failed - Returned a List of ArticleEntity');
                },
              );
            },
          );
        },
      );

      group(
        'fetchSavedArticles function -',
        () {
          test(
            'when fetchSavedArticles fucntion is called and database operation is successful then a list of ArticleEntity should be returned',
            () async {
              when(() {
                return mockArticleLocalDataSource.getArticles();
              }).thenAnswer(
                (invocation) async {
                  return [mockArticleModel];
                },
              );

              final result = await articleRepositoryImpl.fetchSavedArticles();

              result.fold(
                (failure) {
                  fail('Test failed - fucntion returned Failure');
                },
                (articles) {
                  expect(articles, isA<List<ArticleEntity>>());
                },
              );
            },
          );

          test(
            'when fetchSavedArtices is called and exception is thrown then a Failure object should be returned',
            () async {
              when(() {
                return mockArticleLocalDataSource.getArticles();
              }).thenAnswer((invocation) {
                throw Exception('Database Exception');
              });

              final result = await articleRepositoryImpl.fetchSavedArticles();

              result.fold(
                (failure) {
                  expect(failure, isA<Failure>());
                },
                (articles) {
                  fail('Test failed - a list of Article Entitiy returned');
                },
              );
            },
          );
        },
      );

      group(
        'addArticle funcion -',
        () {
          test(
            'when addArticle function is called and database operation is successful then id of the inserted article should be returned',
            () async {
              when(
                () => mockArticleLocalDataSource.addArticle(article: any(named: 'article')),
              ).thenAnswer(
                (invocation) async => 1,
              );

              final result = await articleRepositoryImpl.addArticle(article: mockArticleEntity);

              result.fold(
                (failure) {
                  fail('Test failed - Returned Failure object');
                },
                (id) {
                  expect(id, isA<int>());
                },
              );
            },
          );

          test(
            'when addArticle function is called and exception is thrown then a Failure object should be returned',
            () async {
              when(
                () => mockArticleLocalDataSource.addArticle(article: any(named: 'article')),
              ).thenThrow(
                (invocation) async => Exception('Database Exception'),
              );

              final result = await articleRepositoryImpl.addArticle(article: mockArticleEntity);

              result.fold(
                (failure) {
                  expect(failure, isA<Failure>());
                },
                (id) {
                  fail('Test failed - Returned id of inserted article');
                },
              );
            },
          );
        },
      );

      group(
        'removeArticle function -',
        () {
          test(
            'when removeArticle function is called and database operation is successful then the number of affected rows should be returned',
            () async {
              when(
                () => mockArticleLocalDataSource.removeArticle(article: any(named: 'article')),
              ).thenAnswer(
                (invocation) async => 1,
              );

              final result = await articleRepositoryImpl.removeArticle(article: mockArticleEntity);

              result.fold(
                (failure) {
                  fail('Test failed - Returned Failure object');
                },
                (i) {
                  expect(i, isA<int>());
                },
              );
            },
          );

          test(
            'when removeArticle function is called and exception is thrown then a Failure object should be returned',
            () async {
              when(
                () => mockArticleLocalDataSource.removeArticle(article: any(named: 'article')),
              ).thenThrow(Exception('Database Exception'));

              final result = await articleRepositoryImpl.removeArticle(article: mockArticleEntity);

              result.fold(
                (failure) {
                  expect(failure, isA<Failure>());
                },
                (i) {
                  fail('Test failed - int is returned');
                },
              );
            },
          );
        },
      );
    },
  );
}
