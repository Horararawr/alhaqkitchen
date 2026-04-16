import 'package:alhaqkitchen/database/firebase_service.dart';
import 'package:alhaqkitchen/views/home/homehaq.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({super.key});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  void initState() {
    super.initState();
    // Setelah 3 detik, balik ke Home dan hapus semua history page sebelumnya
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        final user = FirebaseAuth.instance.currentUser;
        final profile = await FirebaseService.getProfile();
        
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context) => HomeHaq(
              email: user?.email ?? "", 
              name: profile?['name'] ?? "User Al-Haq"
            )), 
            (route) => false
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF00357A), // Biru Al-Haq
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              "Order Successful!",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 24, 
                fontFamily: 'BacasimeAntique'
              )
            ),
          ],
        ),
      ),
    );
  }
}