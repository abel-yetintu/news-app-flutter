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

  Future<Either<Failure, List<ArticleEntity>>> execute({required NewsCategory newsCategory}) async {
    return await articleRepository.fetchTopHeadlines(newsCategory: newsCategory);
  }
}

class SearchArticlesUseCase {
  final ArticleRepository articleRepository;

  const SearchArticlesUseCase({required this.articleRepository});

  Future<Either<Failure, List<ArticleEntity>>> execute({required String query}) async {
    return await articleRepository.searchArticles(query: query);
  }
}

class FetchSavedArticlesUseCase {
  final ArticleRepository articleRepository;

  const FetchSavedArticlesUseCase({required this.articleRepository});

  Future<Either<Failure, List<ArticleEntity>>> execute() async {
    return await articleRepository.fetchSavedArticles();
  }
}

class AddArticleUseCase {
  final ArticleRepository articleRepository;

  const AddArticleUseCase({required this.articleRepository});

  Future<Either<Failure, int>> execute({required ArticleEntity article}) async {
    return await articleRepository.addArticle(article: article);
  }
}

class RemoveArticleUseCase {
  final ArticleRepository articleRepository;

  const RemoveArticleUseCase({required this.articleRepository});

  Future<Either<Failure, int>> execute({required ArticleEntity article}) async {
    return await articleRepository.removeArticle(article: article);
  }
}
