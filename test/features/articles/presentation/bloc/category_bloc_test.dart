import 'package:bloc_test/bloc_test.dart';
import 'package:echo/core/enums/enums.dart';
import 'package:echo/features/articles/presentation/bloc/category_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'CategoryBloc -',
    () {
      late CategoryBloc categoryBloc;

      setUp(() {
        categoryBloc = CategoryBloc();
      });

      tearDown(() {
        categoryBloc.close();
      });

      test(
        'initial state of CategoryBloc should be NewsCategory.general',
        () {
          expect(categoryBloc.state, NewsCategory.general);
        },
      );

      blocTest(
        'handles ChangeCategory event',
        build: () => categoryBloc,
        act: (bloc) => bloc.add(ChangeCategory(category: NewsCategory.business)),
        expect: () => [NewsCategory.business],
      );
    },
  );
}
