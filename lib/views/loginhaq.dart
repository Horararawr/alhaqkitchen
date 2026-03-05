import 'package:alhaqkitchen/views/siginhaq.dart';
import 'package:flutter/material.dart';
import 'homehaq.dart';

class LoginHaq extends StatefulWidget {
  const LoginHaq({super.key});

  @override
  State<LoginHaq> createState() => _LoginHaqState();
}

class _LoginHaqState extends State<LoginHaq> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Al-Haq\nConnect", textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 45, height: 1.1)),
              const SizedBox(height: 60),

              _buildInput("Email Address", (v) => v!.isEmpty ? "Wajib diisi, coy!" : null),
              const SizedBox(height: 20),

              TextFormField(
                obscureText: _isObscure,
                style: const TextStyle(color: Colors.white),
                validator: (v) => v!.isEmpty ? "Password jangan kosong dong!" : null,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white60),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFBC9C22)),
                    onPressed: () => setState(() => _isObscure = !_isObscure),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("forgot password?", 
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic)),
                ),
              ),
              
              const SizedBox(height: 20),
              _mainButton("Login", () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeHaq()));
                }
              }),
              
              const SizedBox(height: 20),
              const Text("or", style: TextStyle(color: Color(0xFFBC9C22))),
              const SizedBox(height: 20),
              _socialBtn("Google", Icons.g_mobiledata),
              _socialBtn("Facebook", Icons.facebook),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterHaq()));
                    },
                    child: const Text("Sign up", 
                      style: TextStyle(color: Color(0xFFBC9C22), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String hint, String? Function(String?)? validator) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }

  Widget _mainButton(String label, VoidCallback tap) {
    return SizedBox(width: double.infinity, height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBC9C22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: tap, child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))));
  }

  Widget _socialBtn(String label, IconData icon) {
    return Container(margin: const EdgeInsets.only(bottom: 10), height: 50,
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ));
  }
}