import 'package:dio/dio.dart';
import 'package:echo/core/routing/navigation_service.dart';
import 'package:echo/features/articles/data/data_sources/local/article_local_data_source.dart';
import 'package:echo/features/articles/data/data_sources/local/article_local_data_source_impl.dart';
import 'package:echo/features/articles/data/data_sources/local/database_helper.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source_impl.dart';
import 'package:echo/features/articles/data/repositories/article_repository_impl.dart';
import 'package:echo/features/articles/domain/repositories/article_repository.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/search_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/top_headlines_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  // navigation service
  sl.registerLazySingleton(() => NavigationService(key: sl()));

  // navigator key
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  // blocs

  sl.registerFactory(() => TopHeadlinesBloc(fetchTopHeadlinesUseCase: sl()));

  sl.registerFactory(() => SearchBloc(searchArticleUseCase: sl()));

  sl.registerFactory(() => SavedArticleBloc(addArticleUseCase: sl(), fetchSavedArticlesUseCase: sl(), removeArticleUseCase: sl()));

  // use cases

  sl.registerLazySingleton(() => FetchTopHeadlinesUseCase(articleRepository: sl()));

  sl.registerLazySingleton(() => SearchArticlesUseCase(articleRepository: sl()));

  sl.registerLazySingleton(() => AddArticleUseCase(articleRepository: sl()));

  sl.registerLazySingleton(() => FetchSavedArticlesUseCase(articleRepository: sl()));

  sl.registerLazySingleton(() => RemoveArticleUseCase(articleRepository: sl()));

  // repositories

  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(articleRemoteDataSource: sl(), articleLocalDataSource: sl()));

  // data sources

  sl.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ArticleLocalDataSource>(() => ArticleLocalDataSourceImpl(databaseHelper: sl()));

  // http client
  sl.registerLazySingleton(() => Dio(
        BaseOptions(baseUrl: "https://gnews.io/api/v4"),
      ));

  // local database
  sl.registerLazySingleton(() => DatabaseHelper.instance);
}
