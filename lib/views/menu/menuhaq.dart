import 'package:flutter/material.dart';
import 'lunchbox.dart';

class MenuHaq extends StatelessWidget {
  const MenuHaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Color(0xFFBC9C22))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Menu", style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 35)),
            const SizedBox(height: 30),
            _menuOption(context, "Lunch Box", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LunchBox()))),
            const SizedBox(height: 20),
            _menuOption(context, "Snack Box", () {}),
          ],
        ),
      ),
    );
  }

  Widget _menuOption(BuildContext context, String title, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: double.infinity, height: 100,
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(15)),
        child: Center(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20))),
      ),
    );
  }
}