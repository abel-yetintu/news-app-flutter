import 'package:echo/core/utils/extensions.dart';
import 'package:echo/core/utils/helper_functions.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_state.dart';
import 'package:echo/features/articles/presentation/bloc/saved_articles_event.dart';
import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
    final savedArticleBloc = context.read<SavedArticleBloc>();
    if (savedArticleBloc.state is SavedArticlesInitial || savedArticleBloc.state is SavedArticlesFailed) {
      savedArticleBloc.add(FetchSavedArticles());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(context.screenWidth * .05, context.screenHeight * .02, context.screenWidth * .05, 0),
      child: BlocConsumer<SavedArticleBloc, SavedArticleState>(
        listener: (context, state) {
          if (state is SavedArticlesFailed) {
            HelperFunctions.showErrorSnackBar(message: state.message);
          }
        },
        builder: (context, state) {
          switch (state) {
            case SavedArticlesInitial():
              return Container();
            case SavedArticlesLoading():
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
            case SavedArticlesFetched():
              if (state.articles.isEmpty) {
                return const Center(
                  child: Text('No Saved Articles'),
                );
              }
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
            case SavedArticlesFailed():
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
    );
  }
}
