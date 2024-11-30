import 'package:echo/features/articles/data/data_sources/local/article_local_data_source_impl.dart';
import 'package:echo/features/articles/data/data_sources/local/database_helper.dart';
import 'package:echo/features/articles/data/models/article_model.dart';
import 'package:echo/features/articles/data/models/source_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late ArticleLocalDataSourceImpl articleLocalDataSourceImpl;

  setUpAll(() {
    mockDatabaseHelper = MockDatabaseHelper();
    articleLocalDataSourceImpl = ArticleLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group(
    'ArticleLocalDataSourceImpl -',
    () {
      group(
        'getArticles function -',
        () {
          test(
            'when getArticles function is called and database responds successfuly then a list of ArticleModel should be returned ',
            () async {
              final mockResponse = [
                {
                  "id": 1,
                  "title": "Titile",
                  "description": "Description",
                  "content": "Content",
                  "url": "Url",
                  "image": "image",
                  "publishedAt": 1733819643726,
                  "sourceName": "name",
                  "sourceUrl": "url"
                }
              ];

              when(
                () => mockDatabaseHelper.getArticles(),
              ).thenAnswer(
                (invocation) async => mockResponse,
              );

              final result = await articleLocalDataSourceImpl.getArticles();

              expect(result, isA<List<ArticleModel>>());
            },
          );

          test(
            'when getArticles function is called and database throws an exception then an exception should be thrown',
            () {
              when(
                () => mockDatabaseHelper.getArticles(),
              ).thenThrow(
                Exception('Database Exception'),
              );

              final result = articleLocalDataSourceImpl.getArticles();

              expect(result, throwsException);
            },
          );
        },
      );

      group(
        'addArticle function -',
        () {
          test(
            'when addArticle function is called and database responds successfuly then an id of the inserted article should be returned',
            () async {
              final mockArticle = ArticleModel(
                title: 'title',
                description: 'description',
                content: 'content',
                url: 'url',
                imageUrl: 'imageUrl',
                publishedAt: DateTime.now(),
                source: SourceModel(name: 'name', url: 'url'),
              );

              when(
                () => mockDatabaseHelper.addArticle(any()),
              ).thenAnswer((invocation) async {
                return 1;
              });

              final result = await articleLocalDataSourceImpl.addArticle(article: mockArticle);

              expect(result, isA<int>());
            },
          );

          test(
            'when addArticle function is called and database throws and exception then an exception should be thrown',
            () async {
              final mockArticle = ArticleModel(
                title: 'title',
                description: 'description',
                content: 'content',
                url: 'url',
                imageUrl: 'imageUrl',
                publishedAt: DateTime.now(),
                source: SourceModel(name: 'name', url: 'url'),
              );

              when(
                () => mockDatabaseHelper.addArticle(any()),
              ).thenThrow(
                Exception('Database Exception'),
              );

              final result = articleLocalDataSourceImpl.addArticle(article: mockArticle);

              expect(result, throwsException);
            },
          );
        },
      );

      group(
        'removeArticle function -',
        () {
          test(
            'when removeArticle function is called and database responds successfuly then the amount of deleted article should be returned',
            () async {
              final mockArticle = ArticleModel(
                id: 1,
                title: 'title',
                description: 'description',
                content: 'content',
                url: 'url',
                imageUrl: 'imageUrl',
                publishedAt: DateTime.now(),
                source: SourceModel(name: 'name', url: 'url'),
              );

              when(
                () => mockDatabaseHelper.removeArticle(any()),
              ).thenAnswer(
                (invocation) async => 1,
              );

              final result = await articleLocalDataSourceImpl.removeArticle(article: mockArticle);

              expect(result, isA<int>());
            },
          );

          test(
            'when reomveArticle function is called and database throws an exception then an exception should be thrown',
            () async {
              final mockArticle = ArticleModel(
                id: 1,
                title: 'title',
                description: 'description',
                content: 'content',
                url: 'url',
                imageUrl: 'imageUrl',
                publishedAt: DateTime.now(),
                source: SourceModel(name: 'name', url: 'url'),
              );

              when(
                () => mockDatabaseHelper.removeArticle(any()),
              ).thenThrow(
                Exception('Database Exception'),
              );

              final result = articleLocalDataSourceImpl.removeArticle(article: mockArticle);

              expect(result, throwsException);
            },
          );
        },
      );
    },
  );
}
