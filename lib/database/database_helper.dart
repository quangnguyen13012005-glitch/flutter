import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

// Lớp quản lý toàn bộ thao tác với SQLite
class DatabaseHelper {
  // Singleton: chỉ tạo 1 đối tượng DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static Database? _database;

  // Hàm lấy database
  Future<Database> get database async {
    // Nếu database đã được tạo thì trả về luôn
    if (_database != null) return _database!;

    // Nếu chưa có thì khởi tạo
    _database = await _initDB('todo.db');
    return _database!;
  }

  // Tạo database
  Future<Database> _initDB(String filePath) async {
    // Lấy đường dẫn lưu database
    final dbPath = await getDatabasesPath();

    // Ghép đường dẫn với tên file
    final path = join(dbPath, filePath);

    // Mở database
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Hàm tạo bảng khi database được tạo lần đầu
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tblCongViec(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        status INTEGER NOT NULL
      )
    ''');
  }

  // ==========================
  // Thêm công việc
  // ==========================
  Future<int> insertTask(Task task) async {
    final db = await instance.database;

    return await db.insert(
      'tblCongViec',
      task.toMap(),
    );
  }

  // ==========================
  // Lấy toàn bộ công việc
  // ==========================
  Future<List<Task>> getTasks() async {
    final db = await instance.database;

    final result = await db.query('tblCongViec');

    return result.map((e) => Task.fromMap(e)).toList();
  }
}