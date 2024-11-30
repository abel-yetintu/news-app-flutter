import 'package:dio/dio.dart';

class SearchInterceptor extends Interceptor {
  SearchInterceptor({this.shouldFail = false});

  final bool shouldFail;
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

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('/search')) {
      print('Request URI: ${options.uri}');
      return shouldFail
          ? handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.badResponse,
                response: Response(
                  requestOptions: options,
                  data: {},
                  statusCode: 403,
                ),
              ),
            )
          : handler.resolve(Response(requestOptions: options, data: mockResponse, statusCode: 200));
    }
    if (options.path.contains('/top-headlines')) {
      print('Request URI: ${options.uri}');
      return handler.resolve(Response(requestOptions: options, data: mockResponse, statusCode: 200));
    }
    super.onRequest(options, handler);
  }
}
