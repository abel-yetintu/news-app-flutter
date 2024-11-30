import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/top_headlines_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchTopHeadlinesUsecase extends Mock implements FetchTopHeadlinesUseCase {}

void main() {
  group(
    'TopHeadlinesBloc -',
    () {
      late MockFetchTopHeadlinesUsecase mockFetchTopHeadlinesUsecase;
      late TopHeadlinesBloc topHeadlinesBloc;

      setUp(() {
        mockFetchTopHeadlinesUsecase = MockFetchTopHeadlinesUsecase();
        topHeadlinesBloc = TopHeadlinesBloc(fetchTopHeadlinesUseCase: mockFetchTopHeadlinesUsecase);
      });

      tearDown(() {
        topHeadlinesBloc.close();
      });

      test(
        'TopHeadlinesBloc initial state should be TopHeadlinesInitial',
        () {
          expect(topHeadlinesBloc.state, TopHeadlinesInitial());
        },
      );

      blocTest(
        'handles top headlines fetched successfuly',
        setUp: () {
          when(
            () => mockFetchTopHeadlinesUsecase.execute(newsCategory: NewsCategory.general),
          ).thenAnswer(
            (_) async => const Right([]),
          );
        },
        build: () => topHeadlinesBloc,
        act: (bloc) => bloc.add(FetchTopHeadlines(category: NewsCategory.general)),
        expect: () => [TopHeadlinesLoading(), TopHeadlinesFetched(articles: const [])],
      );

      blocTest(
        'handles top headlines error',
        setUp: () {
          when(
            () => mockFetchTopHeadlinesUsecase.execute(newsCategory: NewsCategory.general),
          ).thenAnswer(
            (_) async => const Left(Failure(message: 'Error Message')),
          );
        },
        build: () => topHeadlinesBloc,
        act: (bloc) => bloc.add(FetchTopHeadlines(category: NewsCategory.general)),
        expect: () => [TopHeadlinesLoading(), TopHeadlinesError(message: 'Error Message')],
      );
    },
  );
}
