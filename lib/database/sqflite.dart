import 'package:alhaqkitchen/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'alhaq_kitchen.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE pelanggan (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, email TEXT, noHp TEXT, alamat TEXT, menuOrder TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    await dbs.insert('user', user.toMap());
  }

  static Future<UserModel?> loginUser({required String email, required String password}) async {
    final dbs = await db();
    final List<Map<String, dynamic>> result = await dbs.query(
      "user",
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query('pelanggan', limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  static Future<void> updateProfile(int id, String nama, String noHp, String alamat) async {
    final dbs = await db();
    await dbs.update(
      'pelanggan',
      {'nama': nama, 'noHp': noHp, 'alamat': alamat},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> addOrder(String nama, String menu) async {
    final dbs = await db();
    await dbs.insert('pelanggan', {
      'nama': nama,
      'menuOrder': menu,
    });
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    final dbs = await db();
    return await dbs.query('pelanggan', where: 'menuOrder IS NOT NULL');
  }

  static Future<void> deleteOrder(int id) async {
    final dbs = await db();
    await dbs.delete('pelanggan', where: 'id = ?', whereArgs: [id]);
  }
}