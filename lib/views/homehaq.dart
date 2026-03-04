import 'package:flutter/material.dart';

class Homehaq extends StatelessWidget {
  const Homehaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Al-Haq Kitchen", 
                  style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 28)),
              const Divider(color: Color(0xFFBC9C22), thickness: 1, indent: 30, endIndent: 30),
              const SizedBox(height: 20),
              const Text("Menu", style: TextStyle(fontFamily: 'BonheurRoyale', color: Color(0xFFBC9C22), fontSize: 35)),
              const SizedBox(height: 10),
              _emptyBox(),
              const SizedBox(height: 30),
              const Text("Latest Order", style: TextStyle(fontFamily: 'BonheurRoyale', color: Color(0xFFBC9C22), fontSize: 35)),
              const SizedBox(height: 10),
              _emptyBox(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00357A),
        selectedItemColor: const Color(0xFFBC9C22),
        unselectedItemColor: const Color(0xFFBC9C22).withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  Widget _emptyBox() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBC9C22)),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}