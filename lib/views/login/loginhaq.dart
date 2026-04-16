import 'package:alhaqkitchen/database/firebase_service.dart';
import 'package:alhaqkitchen/views/sign/siginhaq.dart';
import 'package:alhaqkitchen/views/home/homehaq.dart'; 
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
  bool _isLoading = false;

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
                  const Text(
                    "Al-Haq\nConnect", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'BacasimeAntique', 
                      color: Color(0xFFBC9C22), 
                      fontSize: 45
                    )
                  ),
                  const SizedBox(height: 50),
                  _buildInput("Email Address", Icons.email_outlined, _emailController, false),
                  const SizedBox(height: 20),
                  _buildInput("Password", Icons.lock_outline, _passController, true),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBC9C22), 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Log In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
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

  // Fungsi login dipisah biar rapi dan gak ada dead code
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      try {
        final user = await FirebaseService.loginUser(
          email: _emailController.text, 
          password: _passController.text
        );

        if (user != null) {
          if (!mounted) return;
          // Langsung pindah ke Home
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => HomeHaq(
              email: user.email, 
              name: user.name ?? "User Al-Haq"
            ))
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email atau Password Salah!"),
              backgroundColor: Color(0xFFBC9C22),
            )
          );
        }
      } catch (e) {
        print("Login Error: $e");
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: const Color(0xFFBC9C22),
          )
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildInput(String hint, IconData icon, TextEditingController controller, bool isPass) {
    return TextFormField(
      controller: controller,
      obscureText: isPass ? _isObscure : false,
      style: const TextStyle(color: Colors.white),
      validator: (v) => v == null || v.isEmpty ? "Wajib diisi" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFFBC9C22)),
        suffixIcon: isPass ? IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFBC9C22)),
          onPressed: () => setState(() => _isObscure = !_isObscure),
        ) : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22)), 
          borderRadius: BorderRadius.circular(12)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2), 
          borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }
}