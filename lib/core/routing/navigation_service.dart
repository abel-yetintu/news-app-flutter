import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey;

  NavigationService({required GlobalKey<NavigatorState> key}) : _navigatorKey = key;

  Future<dynamic> routeTo({required String route, dynamic arguments}) {
    return _navigatorKey.currentState!.pushNamed(route, arguments: arguments);
  }

  void goBack() {
    return _navigatorKey.currentState?.pop();
  }
}
