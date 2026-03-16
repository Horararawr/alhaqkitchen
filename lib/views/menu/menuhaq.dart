import 'package:flutter/material.dart';
import 'lunchbox.dart';
import 'snackbox.dart';
import 'requestorder.dart'; // Import file baru

class MenuHaq extends StatelessWidget {
  const MenuHaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 30),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFBC9C22)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), 
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(color: Color(0xFFBC9C22), thickness: 1),
              const SizedBox(height: 25),

              _labelMenu("Lunch Box"),
              const SizedBox(height: 10),
              _menuImageBox(context, 'assets/images/colorful-meal-prep-containers-filled-with-variety-healthy-foods-dark-surface_335952-2335.jpg', 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LunchBox()))),

              const SizedBox(height: 25),

              _labelMenu("Snack Box"),
              const SizedBox(height: 10),
              _menuImageBox(context, 'assets/images/4-dessert-box-manis-yang-cocok-dinikmat-54b6f4.jpg', 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SnackBox()))),

              const SizedBox(height: 25),

              // --- INI MENU REQUEST ORDER BARU ---
              _labelMenu("Request Order"),
              const SizedBox(height: 10),
              _menuImageBox(context, 'assets/images/Food_FP_B117_1004178733.jpg', // Ganti pake asset yg cocok
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestOrder()))),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelMenu(String title) {
    return Text(title, style: const TextStyle(fontFamily: 'BonheurRoyale', color: Color(0xFFBC9C22), fontSize: 40));
  }

  Widget _menuImageBox(BuildContext context, String imagePath, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: double.infinity, height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBC9C22), width: 1.5),
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
      ),
    );
  }
}