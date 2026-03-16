import 'package:alhaqkitchen/views/home/latestorder.dart';
import 'package:flutter/material.dart';
import 'package:alhaqkitchen/views/cart/carthaq.dart';
import 'package:alhaqkitchen/views/profile/profilehaq.dart';
import 'package:alhaqkitchen/views/home/menuhaq.dart';

class HomeHaq extends StatefulWidget {
  final String email;
  final String name; // Tambahin ini biar nangkep nama dari Login/Sign In
  const HomeHaq({super.key, required this.email, required this.name});

  @override
  State<HomeHaq> createState() => _HomeHaqState();
}

class _HomeHaqState extends State<HomeHaq> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Data dilempar ke sini
    final List<Widget> pages = [
      const MainDashboard(),
      const CartHaq(),
      ProfileHaq(userEmail: widget.email, userName: widget.name), // LEMPAR NAMA KE SINI
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00357A),
        selectedItemColor: const Color(0xFFBC9C22),
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), activeIcon: Icon(Icons.shopping_basket), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: ''),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Al-Haq Kitchen", 
              style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 30)),
            const Divider(color: Color(0xFFBC9C22)),
            const SizedBox(height: 10),

            _labelDashboard("Menu"),
            const SizedBox(height: 10),
            _menuBox(
              context, 
              'assets/images/71PW-0pDwxL._AC_UF894,1000_QL80_.jpg', 
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuHaq()))
            ),

            const SizedBox(height: 20),

            _labelDashboard("Latest Order"),
            const SizedBox(height: 10),
            _menuBox(
              context, 
              'assets/images/latestor.jpg', 
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LatestOrder()))
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelDashboard(String title) {
    return Text(
      title, 
      style: const TextStyle(
        fontFamily: 'BonheurRoyale', 
        color: Color(0xFFBC9C22), 
        fontSize: 40
      )
    );
  }

  Widget _menuBox(BuildContext context, String imagePath, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: double.infinity, 
        height: 250, 
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBC9C22), width: 1.5), 
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}