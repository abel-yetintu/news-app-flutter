import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

sealed class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFetched extends SearchState {
  final String query;
  final List<ArticleEntity> articles;

  SearchFetched({required this.query, required this.articles});
}

final class SearchFailed extends SearchState {
  final String message;

  SearchFailed({required this.message});
}
