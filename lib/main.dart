import 'package:alhaqkitchen/views/homehaq.dart'; 
import 'package:alhaqkitchen/views/splashscreenhaq.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Haq Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00357A)), 
        useMaterial3: true,
      ),
      home: const SplashHaq(), 
      routes: {
        // FIX: Tambahin parameter name biar gak merah
        '/home': (context) => const HomeHaq(email: '', name: ''), 
      },
    );
  }
}