import 'package:dartz/dartz.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:echo/features/articles/domain/repositories/article_repository.dart';
import 'package:flutter/widgets.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchTopHeadlines({required NewsCategory newsCategory}) async {
    try {
      final articles = await articleRemoteDataSource.getTopHeadlines(newsCategory: newsCategory);
      return Right(articles.map((article) => article.mapToEntity()).toList());
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<ArticleEntity>>> searchArticles({required String query}) async {
    try {
      final articles = await articleRemoteDataSource.searchArticles(query: query);
      return Right(articles.map((article) => article.mapToEntity()).toList());
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: e.toString()));
    }
  }

}
