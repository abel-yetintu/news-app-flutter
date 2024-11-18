import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_state.dart';
import 'package:echo/features/articles/presentation/bloc/saved_articles_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedArticleBloc extends Bloc<SavedArticlesEvent, SavedArticleState> {
  final FetchSavedArticlesUseCase fetchSavedArticlesUseCase;
  final AddArticleUseCase addArticleUseCase;
  final RemoveArticleUseCase removeArticleUseCase;

  SavedArticleBloc({required this.addArticleUseCase, required this.fetchSavedArticlesUseCase, required this.removeArticleUseCase})
      : super(SavedArticlesInitial()) {
    on<FetchSavedArticles>(_onFetchSavedArticles);
    on<AddArticle>(_onAddArticle);
    on<RemoveArticle>(_onRemoveArticle);
    on<RefetchSavedArticles>(_onRefetchSavedArticles);
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

  void _onRefetchSavedArticles(RefetchSavedArticles event, Emitter<SavedArticleState> emit) async {
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
        HelperFunctions.showErrorSnackBar(message: failure.message);
      },
      (i) {
        if (!event.reAdd) {
          HelperFunctions.showSnackBar(message: 'Article Saved');
        }
        add(RefetchSavedArticles());
      },
    );
  }

  void _onRemoveArticle(RemoveArticle event, Emitter<SavedArticleState> emit) async {
    final result = await removeArticleUseCase.execute(article: event.article);
    result.fold(
      (failure) {
        HelperFunctions.showErrorSnackBar(message: failure.message);
      },
      (i) {
        HelperFunctions.showSnackBar(
          message: 'Article Removed',
          snackBarAction: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              add(AddArticle(article: event.article, reAdd: true));
            },
          ),
        );
        add(RefetchSavedArticles());
      },
    );
  }
}
