import 'package:dartz/dartz.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:echo/features/articles/domain/repositories/article_repository.dart';

class FetchTopHeadlinesUseCase {
  final ArticleRepository articleRepository;

  const FetchTopHeadlinesUseCase({
    required this.articleRepository,
  });

  Future<Either<Failure, List<ArticleEntity>>> execute({required NewsCategory newsCategory}) {
    return articleRepository.fetchTopHeadlines(newsCategory: newsCategory);
  }
}
