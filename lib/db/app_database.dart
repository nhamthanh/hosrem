import 'dart:async';

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqf;

/// App database helper class used to manage the creation and upgrading of your database.
///
/// This class also usually provides the Beans used by the other classes.
class AppDatabase {
  SqfliteAdapter _adapter;

  Future<SqfliteAdapter> _initAdapter() async {
    final Future<String> dbPath = getDatabasesPath();
    return dbPath.then((String p) => path.join(p, 'flutter.db')).then(_createSqfliteAdapter);
  }

  Future<SqfliteAdapter> _createSqfliteAdapter(String dbFile) {
    return sqf
        .openDatabase(dbFile, version: 1, onCreate: _onCreate)
        .then((Database connection) => SqfliteAdapter.fromConnection(connection));
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      final SqfliteAdapter sqfliteAdapter = SqfliteAdapter.fromConnection(db);
      await sqfliteAdapter.close();
    } catch (e) {
      print(e.toString());
    }
  }

  /// Get database adapter.
  Future<SqfliteAdapter> get adapter async {
    if (_adapter != null) {
      return _adapter;
    }

    _adapter = await _initAdapter();
    return _adapter;
  }
}
