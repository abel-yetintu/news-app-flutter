import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/search_event.dart';
import 'package:echo/features/articles/presentation/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchArticlesUseCase _searchArticlesUseCase;

  SearchBloc({required SearchArticlesUseCase searchArticleUseCase})
      : _searchArticlesUseCase = searchArticleUseCase,
        super(SearchInitial()) {
    on<RequestSearch>(_onSearchEvent);
    on<ClearSearch>(_onClearSearch);
  }

  void _onSearchEvent(RequestSearch event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await _searchArticlesUseCase.execute(query: event.query);
    result.fold(
      (failure) {
        emit(SearchFailed(message: failure.message));
      },
      (articles) {
        emit(SearchFetched(query: event.query, articles: articles));
      },
    );
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}
