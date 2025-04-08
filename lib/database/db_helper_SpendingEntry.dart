import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:st4_tuan5_trancongmanh/model/SpendingEntry.dart';
import 'package:st4_tuan5_trancongmanh/model/sinhvien.dart';

class DatabaseHelperSpendingEntry {
  static final DatabaseHelperSpendingEntry _instance =
      DatabaseHelperSpendingEntry._internal();
  static Database? _database;
  factory DatabaseHelperSpendingEntry() {
    return _instance;
  }
  DatabaseHelperSpendingEntry._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_SpendingEntry.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE SpendingEntry(
id INTEGER PRIMARY KEY AUTOINCREMENT, 
  content TEXT NOT NULL, 
  amount REAL NOT NULL, 
  notes TEXT, 
  date TEXT  NOT NULL, 
  category TEXT NOT NULL 
)
''');
      },
    );
  }

  Future<int> insertSpendingEntry(SpendingEntry se) async {
    final db = await DatabaseHelperSpendingEntry().database;
    return await db.insert('SpendingEntry', se.toMap());
  }

  Future<List<SpendingEntry>> getAllSpendingEntry() async {
    final db = await DatabaseHelperSpendingEntry().database;
    final List<Map<String, dynamic>> maps = await db.query('SpendingEntry');
    return List.generate(maps.length, (i) {
      return SpendingEntry.fromMap(maps[i]);
    });
  }

  Future<int> updateSpendingEntry(SpendingEntry se) async {
    final db = await DatabaseHelperSpendingEntry().database;
    return await db.update(
      'SpendingEntry',
      se.toMap(),
      where: 'id = ?',
      whereArgs: [se.id],
    );
  }

  Future<int> deleteSpendingEntry(int id) async {
    final db = await DatabaseHelperSpendingEntry().database;
    return await db.delete('SpendingEntry', where: 'id = ?', whereArgs: [id]);
  }
}
