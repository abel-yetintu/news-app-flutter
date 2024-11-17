part of 'category_bloc.dart';

sealed class CategoryEvent {
  const CategoryEvent();
}

final class ChangeCategory extends CategoryEvent {
  final NewsCategory category;

  ChangeCategory({required this.category});
}
