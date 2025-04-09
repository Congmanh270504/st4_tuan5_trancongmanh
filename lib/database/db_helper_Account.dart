import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:st4_tuan5_trancongmanh/model/account.dart';

class DatabaseHelperAccounts {
  static final DatabaseHelperAccounts _instance =
      DatabaseHelperAccounts._internal();
  static Database? _database;
  factory DatabaseHelperAccounts() {
    return _instance;
  }
  DatabaseHelperAccounts._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_ACCOUNTS.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE ACCOUNTS(
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  email TEXT NOT NULL, 
  password TEXT NOT NULL
)
''');
      },
    );
  }

  Future<int> insertAccount(Account acc) async {
    final db = await DatabaseHelperAccounts().database;
    return await db.insert('ACCOUNTS', acc.toMap());
  }

  Future<List<Account>> getAllAccount() async {
    final db = await DatabaseHelperAccounts().database;
    final List<Map<String, dynamic>> maps = await db.query('ACCOUNTS');
    return List.generate(maps.length, (i) {
      return Account.fromMap(maps[i]);
    });
  }

  Future<int> updateAccount(Account acc) async {
    final db = await DatabaseHelperAccounts().database;
    return await db.update(
      'ACCOUNTS',
      acc.toMap(),
      where: 'id = ?',
      whereArgs: [acc.id],
    );
  }

  Future<int> deleteAccounts(int id) async {
    final db = await DatabaseHelperAccounts().database;
    return await db.delete('ACCOUNTS', where: 'id = ?', whereArgs: [id]);
  }
}
