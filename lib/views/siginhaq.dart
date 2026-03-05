import 'package:alhaqkitchen/views/homehaq.dart';
import 'package:flutter/material.dart';

class RegisterHaq extends StatefulWidget {
  const RegisterHaq({super.key});

  @override
  State<RegisterHaq> createState() => _RegisterHaqState();
}

class _RegisterHaqState extends State<RegisterHaq> {
  final _formKey = GlobalKey<FormState>();
  
  bool _isObscure = true;
  bool _isObscureRepeat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Al-Haq\nConnect",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BacasimeAntique',
                  color: Color(0xFFBC9C22),
                  fontSize: 45,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 40),

              _buildField("Name", Icons.person_outline),
              const SizedBox(height: 15),
              _buildField("Email Address", Icons.email_outlined),
              const SizedBox(height: 15),

              _buildPasswordField("Password", _isObscure, () {
                setState(() => _isObscure = !_isObscure);
              }),
              const SizedBox(height: 15),

              _buildPasswordField("Repeat Password", _isObscureRepeat, () {
                setState(() => _isObscureRepeat = !_isObscureRepeat);
              }),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBC9C22),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeHaq()),
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text("or", style: TextStyle(color: Color(0xFFBC9C22))),
              const SizedBox(height: 20),

              _socialButton("Google", Icons.g_mobiledata),
              const SizedBox(height: 12),
              _socialButton("Facebook", Icons.facebook),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Color(0xFFBC9C22), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      validator: (value) => value!.isEmpty ? "Wajib diisi, Bro!" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFFBC9C22), size: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
        errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.redAccent, width: 2), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildPasswordField(String hint, bool obscure, VoidCallback toggle) {
    return TextFormField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: (value) => value!.isEmpty ? "Wajib diisi!" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFBC9C22), size: 20),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFBC9C22)),
          onPressed: toggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }

  Widget _socialButton(String label, IconData icon) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBC9C22)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}