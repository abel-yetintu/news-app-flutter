import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/data/models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({required NewsCategory newsCategory});
  Future<List<ArticleModel>> searchArticles({required String query});
}
