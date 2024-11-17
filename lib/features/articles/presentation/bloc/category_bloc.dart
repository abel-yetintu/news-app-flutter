import 'package:echo/core/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, NewsCategory> {
  CategoryBloc() : super(NewsCategory.general) {
    on<ChangeCategory>(_onChangeCategory);
  }

  _onChangeCategory(ChangeCategory event, Emitter<NewsCategory> emit) {
    emit(event.category);
  }
}
