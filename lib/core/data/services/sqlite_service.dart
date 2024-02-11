import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wangku/features/category/data/models/category_model.dart';

class SqliteService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/wangku.db';
    return await openDatabase(
      path,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE wallets (
            id INTEGER PRIMARY KEY,
            name TEXT,
            balance INTEGER,
            icon INTEGER,
            color INTEGER,
            created_at INTEGER,
            updated_at INTEGER
          )''');
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY,
            name TEXT,
            transaction_type TEXT,
            icon INTEGER,
            color INTEGER,
            created_at INTEGER,
            updated_at INTEGER
          )''');
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY,
            category_id INTEGER,
            wallet_id INTEGER,
            type TEXT,
            amount INTEGER,
            description TEXT,
            image_path TEXT,
            date_time INTEGER,
            created_at INTEGER,
            updated_at INTEGER,
            FOREIGN KEY (category_id) REFERENCES categories (id),
            FOREIGN KEY (wallet_id) REFERENCES wallets (id)
          )''');
        for (CategoryModel category in categories) {
          await db.insert(
            'categories',
            category.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      },
      version: 1,
    );
  }
}
