class UserModel {
  final String email;
  final String password;
  final String? name;
  final String? foto;
  final String? alamat;
  final String? noHp;

  UserModel({
    required this.email,
    required this.password,
    this.name,
    this.foto,
    this.alamat,
    this.noHp,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'foto': foto ?? '',
      'alamat': alamat ?? '-',
      'noHp': noHp ?? '-',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? 'User Al-Haq',
      foto: map['foto'] ?? '',
      alamat: map['alamat'] ?? '-',
      noHp: map['noHp'] ?? '-',
    );
  }
}