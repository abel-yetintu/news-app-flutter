import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final instance = DatabaseHelper._();

  DatabaseHelper._();

  Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // initialize database

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'articles.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // create database

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE articles(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        content TEXT,
        url TEXT,
        image TEXT,
        publishedAt INTEGER,
        sourceName TEXT,
        sourceUrl TExt
      )
''');
  }

  // get articles

  Future<List<Map<String, dynamic>>> getArticles() async {
    final db = await database;
    return await db.query('articles');
  }

  // add article

  Future<int> addArticle(Map<String, dynamic> article) async {
    final db = await database;
    return db.insert('articles', article, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // remove article

  Future<int> removeArticle(Map<String, dynamic> article) async {
    final db = await database;
    return db.delete('articles', where: 'id = ?', whereArgs: [article['id']]);
  }
}
