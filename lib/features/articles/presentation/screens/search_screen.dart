import 'package:echo/core/utils/extensions.dart';
import 'package:echo/core/utils/helper_widgets.dart';
import 'package:echo/features/articles/presentation/bloc/search_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/search_event.dart';
import 'package:echo/features/articles/presentation/bloc/search_state.dart';
import 'package:echo/features/articles/presentation/widgets/article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    final searchState = context.read<SearchBloc>().state;
    if (searchState is SearchFetched) {
      _textEditingController.text = searchState.query;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(context.screenWidth * .05, context.screenHeight * .02, context.screenWidth * .05, 0),
      child: Column(
        children: [
          // search bar

          TextField(
            controller: _textEditingController,
            textInputAction: TextInputAction.search,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<SearchBloc>().add(RequestSearch(query: value));
              }
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  _textEditingController.clear();
                  context.read<SearchBloc>().add(ClearSearch());
                },
                child: Icon(
                  FontAwesomeIcons.x,
                  size: context.screenWidth * .05,
                ),
              ),
              hintText: 'Search...',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.theme.colorScheme.primary),
              ),
            ),
          ),
          addVerticalSpace(context.screenHeight * .02),

          // search result (articles)

          Expanded(
            child: BlocConsumer<SearchBloc, SearchState>(
              listener: (context, state) {
                if (state is SearchFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: TextStyle(color: context.theme.colorScheme.onError),
                      ),
                      backgroundColor: context.theme.colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                switch (state) {
                  case SearchInitial():
                    return const Center(
                      child: Text("Search for topics you're interested in."),
                    );
                  case SearchLoading():
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
                  case SearchFetched():
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
                  case SearchFailed():
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
        ],
      ),
    );
  }
}
