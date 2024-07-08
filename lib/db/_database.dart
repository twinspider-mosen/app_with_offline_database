import 'dart:async';
import 'package:app_with_local_database/model/product_model.dart';
import 'package:app_with_local_database/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  Future<void> initDb() async {
    await database;
  }

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'app_database.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            userId TEXT,
            name TEXT,
            email TEXT,
            role TEXT,
            phone TEXT,
            password TEXT,
            token TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            quantity TEXT,
            price TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Stream<List<User>> getUsersStream() async* {
    final db = await database;
    yield* db.query('users').asStream().map(
          (List<Map<String, dynamic>> rows) =>
              rows.map((row) => User.fromMap(row)).toList(),
        );
  }

  Stream<List<Product>> getProductStream() async* {
    final db = await database;
    yield* db.query('products').asStream().map(
          (List<Map<String, dynamic>> rows) =>
              rows.map((row) => Product.fromMap(row)).toList(),
        );
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabaseExample() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
    print('Database deleted');
  }
}
