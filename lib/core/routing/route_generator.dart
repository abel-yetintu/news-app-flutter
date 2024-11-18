import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:echo/features/articles/presentation/screens/article_screen.dart';
import 'package:echo/navigation_menu.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoure(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const NavigationMenu());
      case '/article':
        if (args is ArticleEntity) {
          return MaterialPageRoute(builder: (context) => ArticleScreen(article: args));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Route Not Found'),
        ),
      );
    });
  }
}
