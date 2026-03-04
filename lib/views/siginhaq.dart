import 'package:alhaqkitchen/views/homehaq.dart';
import 'package:flutter/material.dart';

class RegisterHaq extends StatelessWidget {
  const RegisterHaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          children: [
            const Text("Al-Haq\nConnect", textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 45)),
            const SizedBox(height: 40),
            _inputFieldReg("Name"),
            const SizedBox(height: 15),
            _inputFieldReg("Email Address"),
            const SizedBox(height: 15),
            _inputFieldReg("Password", isPass: true),
            const SizedBox(height: 15),
            _inputFieldReg("Repeat Password", isPass: true),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBC9C22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Homehaq()), (route) => false);
                },
                child: const Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            const Text("or", style: TextStyle(color: Color(0xFFBC9C22))),
            const SizedBox(height: 30),
            _socialIcon(Icons.g_mobiledata),
            const SizedBox(height: 10),
            _socialIcon(Icons.facebook),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Log In", style: TextStyle(color: Color(0xFFBC9C22), fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _inputFieldReg(String hint, {bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
        suffixIcon: isPass ? const Icon(Icons.visibility_outlined, color: Color(0xFFBC9C22)) : null,
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
     return Container(
      width: double.infinity, height: 45,
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: Colors.white),
    );
  }
}