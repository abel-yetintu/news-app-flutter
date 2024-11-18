import 'package:echo/features/articles/domain/entities/article_entity.dart';

sealed class SavedArticlesEvent {}

final class FetchSavedArticles extends SavedArticlesEvent {}

final class RefetchSavedArticles extends SavedArticlesEvent {}

final class AddArticle extends SavedArticlesEvent {
  final ArticleEntity article;
  final bool reAdd;

  AddArticle({required this.article, required this.reAdd});
}

final class RemoveArticle extends SavedArticlesEvent {
  final ArticleEntity article;

  RemoveArticle({required this.article});
}
