part of 'top_headlines_bloc.dart';

sealed class TopHeadlinesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TopHeadlinesInitial extends TopHeadlinesState {}

final class TopHeadlinesLoading extends TopHeadlinesState {}

final class TopHeadlinesFetched extends TopHeadlinesState {
  final List<ArticleEntity> articles;

  TopHeadlinesFetched({required this.articles});

  @override
  List<Object?> get props => [articles];
}

final class TopHeadlinesError extends TopHeadlinesState {
  final String message;

  TopHeadlinesError({required this.message});

  @override
  List<Object?> get props => [message];
}
