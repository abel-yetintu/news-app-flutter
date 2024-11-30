// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './hook/hooks.dart';
import './step/the_app_is_running.dart';
import './step/i_am_on_the_search_page.dart';
import './step/i_enter_into_the_search_bar.dart';
import './step/i_submit_the_search_query.dart';
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

  group('''Search feature''', () {
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

    testWidgets('''Display articles''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Display articles''');
        await bddSetUp(tester);
        await iAmOnTheSearchPage(tester);
        await iEnterIntoTheSearchBar(tester, 'search term');
        await iSubmitTheSearchQuery(tester);
        await iShouldSeeAListOfArticles(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Display articles''',
          success,
        );
      }
    });
    testWidgets('''Display error tiles''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Display error tiles''');
        await bddSetUp(tester);
        await iAmOnTheSearchPage(tester);
        await iEnterIntoTheSearchBar(tester, 'search term');
        await iSubmitTheSearchQuery(tester);
        await iShouldSeeAListOfErrorTiles(tester);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Display error tiles''',
          success,
        );
      }
    });
  });
}
