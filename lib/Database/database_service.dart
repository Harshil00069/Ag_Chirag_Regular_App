import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:treding/model/user_model.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


class DatabaseService {
  ///Table names

  static String user = "user";

  ///Table data names

  //user

  static String id = "id";
  static String privateKey = "privateKey";
  static String clientcode = "clientcode";
  static String password = "password";
  static String secretKey = "secretKey";
  static String username = "username";

  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();


    final path = join(databasePath, 'trading_buddy.db');

    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;

    }


    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $user(id INTEGER PRIMARY KEY, $privateKey TEXT, $clientcode TEXT,  $password TEXT, $secretKey TEXT, $username TEXT)',
    );
  }

  Future<void> insertUser(UserModel userModel) async {
    final db = await _databaseService.database;

    await db.insert(
      user,
      userModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the breeds from the breeds table.
  Future<List<UserModel>> userS() async {
    final db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query(user);

    return List.generate(
        maps.length, (index) => UserModel.fromJson(maps[index]));
  }

  // A method that updates a breed data from the breeds table.
  Future<void> updateUser(UserModel userModel, int id) async {
    final db = await _databaseService.database;

    // Update the given breed
    await db.update(
      user,
      userModel.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // A method that deletes a breed data from the breeds table.
  Future<void> deleteUser(int id) async {
    final db = await _databaseService.database;

    await db.delete(
      user,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}