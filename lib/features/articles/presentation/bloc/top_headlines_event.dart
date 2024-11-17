part of 'top_headlines_bloc.dart';

sealed class TopHeadlinesEvent {}

final class FetchTopHeadlines extends TopHeadlinesEvent {
  final NewsCategory category;

  FetchTopHeadlines({required this.category});
}
