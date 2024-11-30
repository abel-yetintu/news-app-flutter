// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './hook/hooks.dart';
import './step/the_app_is_running.dart';
import './step/i_should_see_a_list_of_articles.dart';
import './step/i_should_see_a_list_of_error_tiles.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Top headlines feature''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunning(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Display article tiles in top headlines screen''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Display article tiles in top headlines screen''');
        await bddSetUp(tester);
        await iShouldSeeAListOfArticles(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Display article tiles in top headlines screen''',
          success,
        );
      }
    });
    testWidgets('''Display error tiles in top headlines screen''',
        (tester) async {
      var success = true;
      try {
        await beforeEach('''Display error tiles in top headlines screen''');
        await bddSetUp(tester);
        await iShouldSeeAListOfErrorTiles(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Display error tiles in top headlines screen''',
          success,
        );
      }
    });
  });
}
