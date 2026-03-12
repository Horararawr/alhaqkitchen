import 'package:alhaqkitchen/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    // Pake nama baru biar skema 'pelanggan' otomatis ke-create
    return openDatabase(
      join(dbPath, 'alhaq_final_fix.db'),
      version: 1,
      onCreate: (db, version) async {
        // Tabel Auth
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            email TEXT UNIQUE, 
            password TEXT
          )
        ''');
        
        // Tabel Profile (Pakai 'nama' sesuai error di log lo)
        await db.execute('''
          CREATE TABLE pelanggan (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            email TEXT UNIQUE, 
            nama TEXT, 
            noHp TEXT, 
            alamat TEXT, 
            foto TEXT
          )
        ''');

        // Tabel Cart
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            price INTEGER, 
            image TEXT, 
            quantity INTEGER, 
            status TEXT, 
            order_date TEXT,
            notes TEXT
          )
        ''');
      },
    );
  }

  static Future<bool> registerUser(UserModel user) async {
    final db = await DBHelper.database;
    try { 
      await db.insert('user', user.toMap()); 
      // Inisialisasi profile pelanggan pas daftar
      await db.insert('pelanggan', {
        'email': user.email,
        'nama': user.name ?? 'User Al-Haq',
        'noHp': '-',
        'alamat': '-',
        'foto': ''
      });
      return true; 
    } catch (e) { 
      print("Error Register: $e");
      return false; 
    }
  }

  static Future<UserModel?> loginUser({required String email, required String password}) async {
    final db = await DBHelper.database;
    final List<Map<String, dynamic>> result = await db.query(
      "user", 
      where: 'email = ? AND password = ?', 
      whereArgs: [email.trim(), password]
    );
    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

  static Future<Map<String, dynamic>?> getProfile(String email) async {
    final db = await DBHelper.database;
    final results = await db.query('pelanggan', where: 'email = ?', whereArgs: [email], limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  static Future<void> saveProfile(String email, String name, String foto, String noHp, String alamat) async {
    final db = await DBHelper.database;
    // Fix argumen: pastiin semua kolom (email, nama, foto, noHp, alamat) terisi
    await db.insert(
      'pelanggan', 
      {
        'email': email, 
        'nama': name, 
        'foto': foto, 
        'noHp': noHp, 
        'alamat': alamat
      }, 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<void> insertCartItem(Map<String, dynamic> item) async {
    final db = await DBHelper.database;
    await db.insert(
      'cart', 
      item, 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await DBHelper.database;
    return await db.query('cart', orderBy: 'id DESC');
  }
}