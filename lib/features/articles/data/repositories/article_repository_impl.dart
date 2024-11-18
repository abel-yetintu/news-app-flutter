import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/features/articles/data/data_sources/local/article_local_data_source.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source.dart';
import 'package:echo/features/articles/data/models/article_model.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:echo/features/articles/domain/repositories/article_repository.dart';
import 'package:flutter/widgets.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;
  final ArticleLocalDataSource articleLocalDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource, required this.articleLocalDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchTopHeadlines({required NewsCategory newsCategory}) async {
    try {
      final articles = await articleRemoteDataSource.getTopHeadlines(newsCategory: newsCategory);
      return Right(articles.map((article) => article.mapToEntity()).toList());
    } on DioException catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: HelperFunctions.getDioExceptionMessage(e)));
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
    } on DioException catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: HelperFunctions.getDioExceptionMessage(e)));
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchSavedArticles() async {
    try {
      final articles = await articleLocalDataSource.getArticles();
      return Right(articles.map((model) => model.mapToEntity()).toList());
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> addArticle({required ArticleEntity article}) async {
    try {
      final articleModel = ArticleModel.fromEntitiy(entity: article);
      final result = await articleLocalDataSource.addArticle(article: articleModel);
      if (result == 0) {
        const Left(Failure(message: 'Error while saving article'));
      }
      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> removeArticle({required ArticleEntity article}) async {
    try {
      final articleModel = ArticleModel.fromEntitiy(entity: article);
      final result = await articleLocalDataSource.removeArticle(article: articleModel);
      if (result == 0) {
        const Left(Failure(message: 'Error while removing article'));
      }
      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
