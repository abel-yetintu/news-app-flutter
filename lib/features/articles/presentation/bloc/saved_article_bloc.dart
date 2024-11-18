import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_state.dart';
import 'package:echo/features/articles/presentation/bloc/saved_articles_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedArticleBloc extends Bloc<SavedArticlesEvent, SavedArticleState> {
  final FetchSavedArticlesUseCase fetchSavedArticlesUseCase;
  final AddArticleUseCase addArticleUseCase;

  SavedArticleBloc({required this.addArticleUseCase, required this.fetchSavedArticlesUseCase}) : super(SavedArticlesInitial()) {
    on<FetchSavedArticles>(_onFetchSavedArticles);
    on<AddArticle>(_onAddArticle);
  }

  void _onFetchSavedArticles(FetchSavedArticles event, Emitter<SavedArticleState> emit) async {
    emit(SavedArticlesLoading());
    final result = await fetchSavedArticlesUseCase.execute();
    result.fold((failure) {
      emit(SavedArticlesFailed(message: failure.message));
    }, (articles) {
      emit(SavedArticlesFetched(articles: articles));
    });
  }

  void _onAddArticle(AddArticle event, Emitter<SavedArticleState> emit) async {
    final result = await addArticleUseCase.execute(article: event.article);
    result.fold(
      (failure) {
        emit(SavedArticlesFailed(message: failure.message));
        HelperFunctions.showErrorSnackBar(message: failure.message);
      },
      (i) {
        HelperFunctions.showSnackBar(message: 'Article Saved');
        add(FetchSavedArticles());
      },
    );
  }
}
