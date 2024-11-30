import 'package:dio/dio.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source_impl.dart';
import 'package:echo/features/articles/data/models/article_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late final ArticleRemoteDataSourceImpl articleRemoteDataSourceImpl;
  late final MockDioClient mockDioClient;

  setUpAll(() async {
    await dotenv.load();
    mockDioClient = MockDioClient();
    articleRemoteDataSourceImpl = ArticleRemoteDataSourceImpl(client: mockDioClient);
  });

  group(
    'ArticleRemoteDataSourceImpl -',
    () {
      group(
        'getTopheadlines function -',
        () {
          test(
            'when getTopheadlines function is called and status code is 200 then a list of ArticleModel should be returned',
            () async {
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
                  }
                ]
              };

              when(() {
                return mockDioClient.get(any());
              }).thenAnswer((invocation) async {
                return Response(requestOptions: RequestOptions(), statusCode: 200, data: mockResponse);
              });

              final result = await articleRemoteDataSourceImpl.getTopHeadlines(newsCategory: NewsCategory.general);

              expect(result, isA<List<ArticleModel>>());
            },
          );

          test(
            'when getTopheadlines function is called and response is unsuccessful then an exception should be thrwon',
            () async {
              when(
                () {
                  return mockDioClient.get(any());
                },
              ).thenThrow(
                DioException(requestOptions: RequestOptions()),
              );

              final result = articleRemoteDataSourceImpl.getTopHeadlines(newsCategory: NewsCategory.general);

              expect(result, throwsException);
            },
          );
        },
      );

      group(
        'searchArticles function -',
        () {
          test(
            'when searchArticles function is called and status code is 200 a list of ArticleModel should be returned',
            () async {
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
                  }
                ]
              };

              when(() {
                return mockDioClient.get(any());
              }).thenAnswer((invocation) async {
                return Response(requestOptions: RequestOptions(), data: mockResponse);
              });

              final result = await articleRemoteDataSourceImpl.searchArticles(query: 'query');

              expect(result, isA<List<ArticleModel>>());
            },
          );

          test(
            'when searchArticles function is called and response is unsuccessful then an excepiton is thrown',
            () {
              when(() {
                return mockDioClient.get(any());
              }).thenThrow(
                DioException(requestOptions: RequestOptions()),
              );

              final result = articleRemoteDataSourceImpl.searchArticles(query: 'query');

              expect(result, throwsException);
            },
          );
        },
      );
    },
  );
}
