import 'package:dartz/dartz.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> fetchTopHeadlines({required NewsCategory newsCategory});
  Future<Either<Failure, List<ArticleEntity>>> searchArticles({required String query});
  Future<Either<Failure, List<ArticleEntity>>> fetchSavedArticles();
  Future<Either<Failure, int>> addArticle({required ArticleEntity article});
  Future<Either<Failure, int>> removeArticle({required ArticleEntity article});
}
