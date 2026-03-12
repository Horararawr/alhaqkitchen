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
    return openDatabase(
      join(dbPath, 'alhaq_kitchen.db'),
      version: 4, // NAIKKIN KE VERSI 4 BIAR RESET TABEL NYA!
      onCreate: (db, version) async {
        // FIX: Tambahin kolom 'name' di sini!
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            email TEXT UNIQUE, 
            password TEXT
          )
        ''');
        
        await db.execute('CREATE TABLE pelanggan (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, nama TEXT, noHp TEXT, alamat TEXT, foto TEXT)');
        await db.execute('CREATE TABLE orders (id INTEGER PRIMARY KEY AUTOINCREMENT, user_email TEXT, menu_name TEXT, order_date TEXT)');
        
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            price INTEGER, 
            image TEXT, 
            quantity INTEGER, 
            status TEXT, 
            order_date TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Jika lo males hapus app, ini buat nambahin kolom name ke tabel lama
        if (oldVersion < 4) {
          try {
            await db.execute('ALTER TABLE user ADD COLUMN name TEXT');
          } catch (e) {
            print("Kolom name mungkin sudah ada");
          }
        }
      },
    );
  }

  static Future<bool> registerUser(UserModel user) async {
    final db = await DBHelper.database;
    try { 
      await db.insert('user', user.toMap()); 
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
      whereArgs: [email, password]
    );
    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

  // --- Fungsi Lainnya Tetep Sama ---
  static Future<Map<String, dynamic>?> getProfile(String email) async {
    final db = await DBHelper.database;
    final results = await db.query('pelanggan', where: 'email = ?', whereArgs: [email], limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  static Future<void> saveProfile(String email, String nama, String foto, String noHp) async {
    final db = await DBHelper.database;
    await db.insert('pelanggan', {'email': email, 'nama': nama, 'foto': foto, 'noHp': noHp, 'alamat': ''}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertCartItem(Map<String, dynamic> item) async {
    final db = await DBHelper.database;
    await db.insert('cart', item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await DBHelper.database;
    return await db.query('cart', where: 'status = ?', whereArgs: ['cart']);
  }

  static Future<List<Map<String, dynamic>>> getCompletedOrders() async {
    final db = await DBHelper.database;
    return await db.query('cart', where: 'status = ?', whereArgs: ['completed']);
  }

  static Future<void> deleteCartItem(int id) async {
    final db = await DBHelper.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateCartQuantity(int id, int newQuantity) async {
    final db = await DBHelper.database;
    await db.update('cart', {'quantity': newQuantity}, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> checkoutCart(int id, String date) async {
    final db = await DBHelper.database;
    await db.update('cart', {'status': 'completed', 'order_date': date}, where: 'id = ?', whereArgs: [id]);
  }
}