import 'package:flutter/material.dart';
import '../login/loginhaq.dart';

class SplashHaq extends StatefulWidget {
  const SplashHaq({super.key});

  @override
  State<SplashHaq> createState() => _SplashHaqState();
}

class _SplashHaqState extends State<SplashHaq> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginHaq()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Al-Haq\nConnect",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BacasimeAntique',
                color: Color(0xFFBC9C22),
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 10),
            Container(height: 1, width: 150, color: const Color(0xFFBC9C22)),
            const SizedBox(height: 10),
            const Text(
              "Al-Haq Kitchen",
              style: TextStyle(
                fontFamily: 'BonheurRoyale',
                color: Color(0xFFBC9C22),
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}