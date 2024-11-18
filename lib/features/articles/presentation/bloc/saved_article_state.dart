import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

sealed class SavedArticleState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SavedArticlesInitial extends SavedArticleState {}

final class SavedArticlesLoading extends SavedArticleState {}

final class SavedArticlesFetched extends SavedArticleState {
  final List<ArticleEntity> articles;

  SavedArticlesFetched({required this.articles});

  @override
  List<Object?> get props => [articles];
}

final class SavedArticlesFailed extends SavedArticleState {
  final String message;

  SavedArticlesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
