import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_headlines_event.dart';
part 'top_headlines_state.dart';

class TopHeadlinesBloc extends Bloc<TopHeadlinesEvent, TopHeadlinesState> {
  final FetchTopHeadlinesUseCase _fetchTopHeadlinesUseCase;

  TopHeadlinesBloc({required FetchTopHeadlinesUseCase fetchTopHeadlinesUseCase})
      : _fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase,
        super(TopHeadlinesInitial()) {
    on<FetchTopHeadlines>(_onFetchTopHeadlines);
  }

  void _onFetchTopHeadlines(FetchTopHeadlines event, Emitter<TopHeadlinesState> emit) async {
    emit(TopHeadlinesLoading());
    final result = await _fetchTopHeadlinesUseCase.execute(newsCategory: event.category);
    result.fold((failure) {
      emit(TopHeadlinesError(message: failure.message));
    }, (articles) {
      emit(TopHeadlinesFetched(articles: articles));
    });
  }
}
