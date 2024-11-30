import 'dart:async';
import 'package:dio/dio.dart';
import 'package:echo/core/dependecy_injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../network/search_interceptor.dart';
import '../network/top_headlines_interceptor.dart';

abstract class Hooks {
  const Hooks._();

  static FutureOr<void> beforeEach(String title, [List<String>? tags]) {
    // Add logic for beforeEach
    print('Inside beforeEach');
    print(title);
    switch (title) {
      case 'Display articles':
        final client = sl<Dio>()..interceptors.clear();
        client.interceptors.add(SearchInterceptor());
        break;
      case 'Display error tiles':
        final client = sl<Dio>()..interceptors.clear();
        client.interceptors.add(SearchInterceptor(shouldFail: true));
        break;
      case 'Display article tiles in top headlines screen':
        final client = sl<Dio>()..interceptors.clear();
        client.interceptors.add(TopHeadlinesInterceptor());
        break;
      case 'Display error tiles in top headlines screen':
        final client = sl<Dio>()..interceptors.clear();
        client.interceptors.add(TopHeadlinesInterceptor(shouldFail: true));
        break;
    }
  }

  static FutureOr<void> beforeAll() async {
    // Add logic for beforeAll
    await initSL();
    await dotenv.load();
  }

  static FutureOr<void> afterEach(
    String title,
    bool success, [
    List<String>? tags,
  ]) {
    // Add logic for afterEach
  }

  static FutureOr<void> afterAll() {
    // Add logic for afterAll
  }
}
