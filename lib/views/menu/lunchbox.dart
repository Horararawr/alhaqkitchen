import 'package:flutter/material.dart';
import '../lunchbox/lunchboxmenu.dart';

class LunchBox extends StatelessWidget {
  const LunchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFBC9C22)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Lunch Box",
          style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const Divider(color: Color(0xFFBC9C22), thickness: 1), 
            const SizedBox(height: 20),

            // Menu 1
            _itemMenu(
              context,
              "Lunch Box #1", 
              "Ayam Teriyaki, Nasi Putih, & Salad Mayo", 
              'assets/images/teriyaki-chicken-with-rice-fresh-herbs-beige-plate-traditional-japanese-dish-side-view-close-up_166116-4589.jpg',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LunchBoxMenu(
                menuName: "Lunch Box #1", menuPrice: 20000,
                menuDesc: "Ayam Teriyaki, Nasi Putih, & Salad Mayo",
                menuImg: 'assets/images/teriyaki-chicken-with-rice-fresh-herbs-beige-plate-traditional-japanese-dish-side-view-close-up_166116-4589.jpg',
              ))),
            ),
            const SizedBox(height: 30),

            // Menu 2
            _itemMenu(
              context,
              "Lunch Box #2", 
              "Beef Teriyaki, Nasi Putih, & Salad Mayo", 
              'assets/images/instant-pot-teriyaki-beef-recipe.webp',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LunchBoxMenu(
                menuName: "Lunch Box #2", menuPrice: 25000,
                menuDesc: "Beef Teriyaki, Nasi Putih, & Salad Mayo",
                menuImg: 'assets/images/instant-pot-teriyaki-beef-recipe.webp',
              ))),
            ),
            const SizedBox(height: 30),

            // Menu 3
            _itemMenu(
              context,
              "Lunch Box #3", 
              "Ayam Briyani, Nasi Brasmati, & Kentang", 
              'assets/images/plate-biryani-with-bunch-food-it.jpg',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LunchBoxMenu(
                menuName: "Lunch Box #3", menuPrice: 25000,
                menuDesc: "Ayam Briyani, Nasi Brasmati, & Kentang",
                menuImg: 'assets/images/plate-biryani-with-bunch-food-it.jpg',
              ))),
            ),
            const SizedBox(height: 30),

            // Menu 4
            _itemMenu(
              context,
              "Lunch Box #4", 
              "Beef Rendang, Nasi Putih, & Telor Bulet", 
              'assets/images/Beef-Rendang-Indonesian-Curry-sw.jpg',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LunchBoxMenu(
                menuName: "Lunch Box #4", menuPrice: 20000,
                menuDesc: "Beef Rendang, Nasi Putih, & Telor Bulet",
                menuImg: 'assets/images/Beef-Rendang-Indonesian-Curry-sw.jpg',
              ))),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // DI SINI KUNCI BIAR BISA DIPENCET
  Widget _itemMenu(BuildContext context, String title, String description, String imagePath, VoidCallback tap) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontFamily: 'BonheurRoyale', color: Color(0xFFBC9C22), fontSize: 35),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFFFFFFF), fontSize: 20),
        ),
        const SizedBox(height: 20),
        
        // INI DIA: Gambar dibungkus InkWell biar bisa di-klik
        InkWell(
          onTap: tap, // Ini bakal jalanin Navigator.push di atas
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFBC9C22), width: 1.5),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}