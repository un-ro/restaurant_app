import 'package:path/path.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ??= DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  static String _tableName = 'favorite';

  Future<Database> _initDatabase() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            pictureId TEXT,
            name TEXT,
            city TEXT,
            rating TEXT,
            )''',
        );
      },
      version: 1,
    );
    return db;
  }

  // Add Favorite
  Future<void> addFavorite(Favorite favorite) async {
    final Database db = await database;
    await db.insert(_tableName, favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Data saved');
  }

  // Get Favorite
  Future<List<Favorite>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((fav) => Favorite.fromMap(fav)).toList();
  }

  // Get by Id Favorite
  Future<Favorite> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map((fav) => Favorite.fromMap(fav)).first;
  }

  // Delete Favorite
  Future<void> removeFavorite(String id) async {
    final Database db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
