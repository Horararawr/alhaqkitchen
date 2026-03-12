import 'package:alhaqkitchen/database/sqflite.dart';
import 'package:alhaqkitchen/views/siginhaq.dart';
import 'package:alhaqkitchen/views/homehaq.dart'; // Pastiin path ini bener
import 'package:flutter/material.dart';

class LoginHaq extends StatefulWidget {
  const LoginHaq({super.key});

  @override
  State<LoginHaq> createState() => _LoginHaqState();
}

class _LoginHaqState extends State<LoginHaq> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Al-Haq\nConnect", textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 45)),
                  const SizedBox(height: 50),
                  _buildInput("Email Address", Icons.email_outlined, _emailController),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passController, obscureText: _isObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password", hintStyle: const TextStyle(color: Colors.white60),
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFBC9C22)),
                      suffixIcon: IconButton(icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFBC9C22)), 
                      onPressed: () => setState(() => _isObscure = !_isObscure)),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2), borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBC9C22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var user = await DBHelper.loginUser(email: _emailController.text, password: _passController.text);
                          if (user != null) {
                            if (!mounted) return;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeHaq(
                              email: user.email, 
                              name: user.name ?? "User Al-Haq" // FIX: Pakai .name
                            )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email/PW Salah!")));
                          }
                        }
                      },
                      child: const Text("Log In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterHaq())),
                    child: const Text("Belum punya akun? Sign Up", style: TextStyle(color: Color(0xFFBC9C22))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String hint, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller, style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint, hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFFBC9C22)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}