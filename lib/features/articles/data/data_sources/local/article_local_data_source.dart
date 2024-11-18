import 'package:echo/features/articles/data/models/article_model.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getArticles();
  Future<int> addArticle({required ArticleModel article});
  Future<int> removeArticle({required ArticleModel article});
}
