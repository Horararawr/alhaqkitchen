class UserModel {
  final int? id;
  final String name;     // <--- INI HARUS ADA
  final String email;
  final String password;

  UserModel({
    this.id,
    required this.name,  // <--- INI JUGA
    required this.email,
    required this.password,
  });

  // Buat simpan ke Database (Convert ke Map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,      // <--- INI HARUS COCOK SAMA KOLOM DB
      'email': email,
      'password': password,
    };
  }

  // Buat ambil dari Database (Convert ke Object)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'] ?? '', // <--- AMBIL DATA DARI KOLOM 'name'
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}