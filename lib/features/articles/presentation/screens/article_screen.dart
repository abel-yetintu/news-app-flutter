import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/presentation/bloc/saved_article_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/saved_articles_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleEntity article;
  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.article.url))
      ..setBackgroundColor(Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SavedArticleBloc>().add(AddArticle(article: widget.article));
        },
        child: const FaIcon(FontAwesomeIcons.heart),
      ),
    );
  }
}
