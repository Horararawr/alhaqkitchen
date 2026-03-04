import 'package:alhaqkitchen/views/homehaq.dart';
import 'package:alhaqkitchen/views/siginhaq.dart';
import 'package:flutter/material.dart';

class LoginHaq extends StatelessWidget {
  const LoginHaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          children: [
            const Text(
              "Al-Haq\nConnect",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BacasimeAntique',
                color: Color(0xFFBC9C22),
                fontSize: 45,
              ),
            ),
            const SizedBox(height: 60),

            _buildTextField("Email Address"),
            const SizedBox(height: 20),

            _buildTextField("Password", isPassword: true),
            
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "forgot password?",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homehaq()),
                  );
                },
                child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text("or", style: TextStyle(color: Color(0xFFBC9C22))),
            const SizedBox(height: 20),
            
            _socialButton("Google", Icons.g_mobiledata),
            _socialButton("Facebook", Icons.facebook),
            
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterHaq()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Color(0xFFBC9C22), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword ? const Icon(Icons.visibility_outlined, color: Color(0xFFBC9C22)) : null,
      ),
    );
  }

  Widget _socialButton(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBC9C22)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(label, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
      ),
    );
  }
}