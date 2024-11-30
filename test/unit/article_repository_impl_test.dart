import 'package:dio/dio.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/data/data_sources/local/article_local_data_source_impl.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source_impl.dart';
import 'package:echo/features/articles/data/models/article_model.dart';
import 'package:echo/features/articles/data/models/source_model.dart';
import 'package:echo/features/articles/data/repositories/article_repository_impl.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleRemoteDataSource extends Mock implements ArticleRemoteDataSourceImpl {}

class MockArticleLocalDataSource extends Mock implements ArticleLocalDataSourceImpl {}

void main() {
  late final ArticleRemoteDataSourceImpl articleRemoteDataSourceImpl;
  late final ArticleLocalDataSourceImpl articleLocalDataSourceImpl;
  late final ArticleRepositoryImpl articleRepositoryImpl;

  setUpAll(
    () {
      articleRemoteDataSourceImpl = MockArticleRemoteDataSource();
      articleLocalDataSourceImpl = MockArticleLocalDataSource();
      articleRepositoryImpl = ArticleRepositoryImpl(articleRemoteDataSource: articleRemoteDataSourceImpl, articleLocalDataSource: articleLocalDataSourceImpl);
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
                return articleRemoteDataSourceImpl.getTopHeadlines(newsCategory: NewsCategory.general);
              }).thenAnswer((invocation) async {
                return [
                  ArticleModel(
                    title: 'title',
                    description: 'description',
                    content: 'content',
                    url: 'url',
                    imageUrl: 'imageUrl',
                    publishedAt: DateTime.now(),
                    source: SourceModel(name: 'name', url: 'url'),
                  ),
                ];
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
                return articleRemoteDataSourceImpl.getTopHeadlines(newsCategory: NewsCategory.general);
              }).thenAnswer((invocation) {
                throw DioException(
                    requestOptions: RequestOptions(),
                    response: Response(
                      requestOptions: RequestOptions(),
                    ));
              });

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
        'fetchSavedArticles function -',
        () {
          test(
            'when fetchSavedArticles fucntion is called and is successful response then a list of ArticleEntity should be returned',
            () async {
              when(() {
                return articleLocalDataSourceImpl.getArticles();
              }).thenAnswer(
                (invocation) async {
                  return [
                    ArticleModel(
                      title: 'title',
                      description: 'description',
                      content: 'content',
                      url: 'url',
                      imageUrl: 'imageUrl',
                      publishedAt: DateTime.now(),
                      source: SourceModel(name: 'name', url: 'url'),
                    ),
                  ];
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
                return articleLocalDataSourceImpl.getArticles();
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
    },
  );
}
