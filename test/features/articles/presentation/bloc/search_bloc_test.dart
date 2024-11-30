import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:echo/features/articles/domain/failures/failures.dart';
import 'package:echo/features/articles/domain/usecases/article_usecases.dart';
import 'package:echo/features/articles/presentation/bloc/search_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/search_event.dart';
import 'package:echo/features/articles/presentation/bloc/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchArticleUsecase extends Mock implements SearchArticlesUseCase {}

void main() {
  group(
    'SearchBloc -',
    () {
      late MockSearchArticleUsecase mockSearchArticleUsecase;
      late SearchBloc searchBloc;

      setUp(() {
        mockSearchArticleUsecase = MockSearchArticleUsecase();
        searchBloc = SearchBloc(searchArticleUseCase: mockSearchArticleUsecase);
      });

      tearDown(() {
        searchBloc.close();
      });

      test(
        'initial state of SearchBloc should be SearchInitial',
        () {
          expect(searchBloc.state, SearchInitial());
        },
      );

      blocTest(
        'handles RequestSearch event with successful response',
        setUp: () {
          when(
            () => mockSearchArticleUsecase.execute(query: any(named: 'query')),
          ).thenAnswer(
            (_) async => const Right([]),
          );
        },
        build: () => searchBloc,
        act: (bloc) => bloc.add(RequestSearch(query: 'query')),
        expect: () => [SearchLoading(), SearchFetched(query: 'query', articles: const [])],
      );

      blocTest(
        'handles RequestSearch event with Failure response',
        setUp: () {
          when(
            () => mockSearchArticleUsecase.execute(query: any(named: 'query')),
          ).thenAnswer(
            (_) async => const Left(Failure(message: 'Error Message')),
          );
        },
        build: () => searchBloc,
        act: (bloc) => bloc.add(RequestSearch(query: 'query')),
        expect: () => [SearchLoading(), SearchFailed(message: 'Error Message')],
      );

      blocTest(
        'handles ClearSearch event',
        build: () => searchBloc,
        act: (bloc) => bloc.add(ClearSearch()),
        expect: () => [SearchInitial()],
      );
    },
  );
}
