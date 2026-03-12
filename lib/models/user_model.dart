class UserModel {
  final String email;
  final String password;
  final String? name;

  UserModel({required this.email, required this.password, this.name});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password, 'name': name};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? 'User Al-Haq',
    );
  }
}