import 'package:echo/features/articles/data/data_sources/local/article_local_data_source.dart';
import 'package:echo/features/articles/data/data_sources/local/database_helper.dart';
import 'package:echo/features/articles/data/models/article_model.dart';

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final DatabaseHelper _databaseHelper;

  ArticleLocalDataSourceImpl({required DatabaseHelper databaseHelper}) : _databaseHelper = databaseHelper;

  @override
  Future<List<ArticleModel>> getArticles() async {
    final result = await _databaseHelper.getArticles();
    final articles = result.isEmpty ? <ArticleModel>[] : result.map((map) => ArticleModel.fromDB(map)).toList();
    return articles;
  }

  @override
  Future<int> addArticle({required ArticleModel article}) async {
    final result = await _databaseHelper.addArticle(article.toDB());
    return result;
  }
}
