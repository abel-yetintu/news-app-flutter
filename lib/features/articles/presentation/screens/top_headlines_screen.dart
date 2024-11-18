import 'package:echo/core/enums/enums.dart';
import 'package:echo/core/utils/extensions.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/core/utils/helper_widgets.dart';
import 'package:echo/features/articles/presentation/bloc/category_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/top_headlines_bloc.dart';
import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:echo/features/articles/presentation/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopHeadlinesScreen extends StatefulWidget {
  const TopHeadlinesScreen({super.key});

  @override
  State<TopHeadlinesScreen> createState() => _TopHeadlinesScreenState();
}

class _TopHeadlinesScreenState extends State<TopHeadlinesScreen> {
  @override
  void initState() {
    super.initState();
    final topHeadlinesBloc = context.read<TopHeadlinesBloc>();
    final categoryBloc = context.read<CategoryBloc>();
    if (topHeadlinesBloc.state is! TopHeadlinesFetched) {
      topHeadlinesBloc.add(FetchTopHeadlines(category: categoryBloc.state));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // categories
        Padding(
          padding: EdgeInsets.fromLTRB(context.screenWidth * .05, context.screenHeight * .02, 0, 0),
          child: BlocConsumer<CategoryBloc, NewsCategory>(
            listener: (context, state) {
              context.read<TopHeadlinesBloc>().add(FetchTopHeadlines(category: state));
            },
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List<Widget>.from(
                    NewsCategory.values.map((category) {
                      return CategoryChip(
                        category: category,
                        selectedCategory: state,
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
        addVerticalSpace(context.screenHeight * .02),

        // top headlines
        _buildTopHeadlines(),
      ],
    );
  }

  Widget _buildTopHeadlines() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05, vertical: 0),
        child: BlocConsumer<TopHeadlinesBloc, TopHeadlinesState>(
          listener: (context, state) {
            if (state is TopHeadlinesError) {
              HelperFunctions.showErrorSnackBar(message: state.message);
            }
          },
          builder: (context, state) {
            switch (state) {
              case TopHeadlinesInitial():
                return Container();
              case TopHeadlinesLoading():
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 7,
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey[300]);
                  },
                  itemBuilder: (context, index) {
                    return ArticleTile.loading(context);
                  },
                );
              case TopHeadlinesFetched():
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.articles.length,
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey[300]);
                  },
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return ArticleTile(article: article);
                  },
                );
              case TopHeadlinesError():
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 7,
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey[300]);
                  },
                  itemBuilder: (context, index) {
                    return ArticleTile.error(context);
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
