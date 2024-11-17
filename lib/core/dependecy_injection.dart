import 'package:dio/dio.dart';
import 'package:echo/core/routing/navigation_service.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source.dart';
import 'package:echo/features/articles/data/data_sources/remote/article_remote_data_source_impl.dart';
import 'package:echo/features/articles/data/repositories/article_repository_impl.dart';
import 'package:echo/features/articles/domain/repositories/article_repository.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/search_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/top_headlines_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  sl.registerLazySingleton(() => NavigationService(key: sl()));

  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  sl.registerFactory(() => TopHeadlinesBloc(fetchTopHeadlinesUseCase: sl()));

  sl.registerLazySingleton(() => FetchTopHeadlinesUseCase(articleRepository: sl()));

  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(articleRemoteDataSource: sl()));

  sl.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton(() => Dio());

  sl.registerFactory(() => SearchBloc(searchArticleUseCase: sl()));

  sl.registerLazySingleton(() => SearchArticlesUseCase(articleRepository: sl()));
}
