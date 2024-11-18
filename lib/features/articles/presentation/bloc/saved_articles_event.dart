import 'package:echo/features/articles/domain/entities/article_entity.dart';

sealed class SavedArticlesEvent {}

final class FetchSavedArticles extends SavedArticlesEvent {}

final class AddArticle extends SavedArticlesEvent {
  final ArticleEntity article;

  AddArticle({required this.article});
}
