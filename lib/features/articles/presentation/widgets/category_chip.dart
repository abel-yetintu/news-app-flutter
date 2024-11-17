import 'package:echo/core/enums/enums.dart';
import 'package:echo/core/utils/extensions.dart';
import 'package:echo/features/articles/presentation/bloc/category_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryChip extends StatelessWidget {
  final NewsCategory category;
  final NewsCategory selectedCategory;
  const CategoryChip({super.key, required this.category, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CategoryBloc>().add(ChangeCategory(category: category));
      },
      child: Container(
        margin: EdgeInsets.only(right: context.screenWidth * .02),
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02, vertical: context.screenHeight * .01),
        decoration: BoxDecoration(
          color: category == selectedCategory ? context.theme.colorScheme.primaryContainer : null,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: .5),
        ),
        child: Text(
          category.name.capitalize(),
          style: TextStyle(
            color: category == selectedCategory ? context.theme.colorScheme.onTertiaryContainer : context.theme.colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
