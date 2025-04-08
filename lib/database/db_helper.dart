import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:st4_tuan5_trancongmanh/model/sinhvien.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database? _database;
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_qlsv.db');
    print("Database path: $path"); // Log the database path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print("Creating table sinhviens"); // Log table creation
        await db.execute('''
CREATE TABLE sinhviens(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
email TEXT UNIQUE NOT NULL
)
''');
      },
    );
  }

  Future<int> insertSinhVien(SinhVien sv) async {
    final db = await DatabaseHelper().database;
    return await db.insert('sinhviens', sv.toMap());
  }

  Future<List<SinhVien>> getAllSinhVien() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('sinhviens');
    return List.generate(maps.length, (i) {
      return SinhVien.fromMap(maps[i]);
    });
  }

  Future<int> updateSinhVien(SinhVien sv) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'sinhviens',
      sv.toMap(),
      where: 'id = ?',
      whereArgs: [sv.id],
    );
  }
}
