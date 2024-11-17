import 'package:dio/dio.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/core/environment.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source.dart';
import 'package:echo/features/articles/data/models/article_model.dart';

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio client;

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getTopHeadlines({required NewsCategory newsCategory}) async {
    final result = await client.get('https://gnews.io/api/v4/top-headlines?apikey=${Environment.apiKey}&lang=en&category=${newsCategory.name}');
    final data = result.data;
    return List<ArticleModel>.from(
      data['articles'].map((map) {
        return ArticleModel.fromMap(map);
      }),
    );
  }
}