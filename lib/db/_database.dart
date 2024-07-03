import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "myapp.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT,email TEXT, password TEXT)");
  }

  Future<int> saveUser(String username, String email, String password) async {
    var dbClient = await db;
    int res = await dbClient!.insert(
        "User", {'username': username, 'email': email, 'password': password});
    return res;
  }

  Future checkUser(String username) async {
    var dbClient = await db;
    var result = await dbClient!
        .rawQuery("SELECT * FROM User WHERE username = '$username'");
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getUserByUsernameAndPassword(
      String username, String password) async {
    var dbClient = await db;
    var result = await dbClient!.rawQuery(
        "SELECT * FROM User WHERE username = '$username' AND password = '$password'");
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateAuthToken(int userId, String authToken) async {
    var dbClient = await db;
    return await dbClient!.update(
      'User',
      {'authToken': authToken},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}
