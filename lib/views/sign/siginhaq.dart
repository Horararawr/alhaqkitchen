import 'package:alhaqkitchen/database/firebase_service.dart';
import 'package:alhaqkitchen/views/home/homehaq.dart'; // Pastiin path ini bener
import 'package:flutter/material.dart';

class RegisterHaq extends StatefulWidget {
  const RegisterHaq({super.key});

  @override
  State<RegisterHaq> createState() => _RegisterHaqState();
}

class _RegisterHaqState extends State<RegisterHaq> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isObscure = true;
  bool _isObscureRepeat = true;

  void _showSuccessAlert(String email, String name) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: const Color(0xFF00357A),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent),
            SizedBox(width: 10),
            Text("Berhasil!", style: TextStyle(color: Color(0xFFBC9C22))),
          ],
        ),
        content: const Text("Akun kamu berhasil dibuat.", style: TextStyle(color: Colors.white)),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBC9C22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                // Langsung masuk ke Home, hapus semua history route
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeHaq(email: email, name: name)),
                  (route) => false,
                );
              },
              child: const Text("masuk", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Al-Haq\nConnect", textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 45, height: 1.1)),
                  const SizedBox(height: 40),
                  _buildField("Full Name", Icons.person_outline, _nameController, (v) {
                    if (v == null || v.isEmpty) return "Nama jangan kosong!";
                    return null;
                  }),
                  const SizedBox(height: 15),
                  _buildField("Email Address", Icons.email_outlined, _emailController, (v) {
                    if (v == null || v.isEmpty || !v.contains("@gmail.com")) return "Email @gmail.com wajib!";
                    return null;
                  }),
                  const SizedBox(height: 15),
                  _buildPasswordField("Password", _isObscure, _passController, () {
                    setState(() => _isObscure = !_isObscure);
                  }, (v) {
                    if (v == null || v.length < 8) return "Minimal 8 karakter!";
                    return null;
                  }),
                  const SizedBox(height: 15),
                  _buildPasswordField("Repeat Password", _isObscureRepeat, _confirmPassController, () {
                    setState(() => _isObscureRepeat = !_isObscureRepeat);
                  }, (v) {
                    if (v != _passController.text) return "Password beda, Cuk!";
                    return null;
                  }),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBC9C22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseService.registerUser(
                              email: _emailController.text,
                              password: _passController.text,
                              username: _nameController.text,
                            );
                            _showSuccessAlert(_emailController.text, _nameController.text);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Email udah terdaftar atau error lain: $e"))
                            );
                          }
                        }
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Sudah punya akun? Login", style: TextStyle(color: Color(0xFFBC9C22)))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, TextEditingController controller, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint, hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFFBC9C22)),
        filled: true, fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildPasswordField(String hint, bool obscure, TextEditingController controller, VoidCallback toggle, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller, obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint, hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFBC9C22)),
        suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFBC9C22)), onPressed: toggle),
        filled: true, fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}