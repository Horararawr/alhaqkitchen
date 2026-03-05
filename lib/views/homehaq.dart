import 'package:flutter/material.dart';
import 'package:alhaqkitchen/views/cart/carthaq.dart';
import 'package:alhaqkitchen/views/profile/profilehaq.dart';
import 'package:alhaqkitchen/views/menu/menuhaq.dart';

class HomeHaq extends StatefulWidget {
  const HomeHaq({super.key});

  @override
  State<HomeHaq> createState() => _HomeHaqState();
}

class _HomeHaqState extends State<HomeHaq> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const MainDashboard(),
    const CartHaq(),
    const ProfileHaq(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00357A),
        selectedItemColor: const Color(0xFFBC9C22),
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const Text("Al-Haq Kitchen", style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 28)),
          const Divider(color: Color(0xFFBC9C22)),
          const SizedBox(height: 20),
          _menuBox("Menu", () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuHaq()))),
          const SizedBox(height: 20),
          _menuBox("Latest Order", () {}),
        ],
      ),
    );
  }

  Widget _menuBox(String title, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: double.infinity, height: 180,
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(15)),
        child: Center(child: Text(title, style: const TextStyle(fontFamily: 'BonheurRoyale', color: Color(0xFFBC9C22), fontSize: 35))),
      ),
    );
  }
}