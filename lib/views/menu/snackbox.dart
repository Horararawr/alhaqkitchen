import 'package:flutter/material.dart';
import '../snackbox/snackboxmenu.dart';

class SnackBox extends StatelessWidget {
  const SnackBox({super.key});

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
          "Snack Box",
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

            // Snack Box #1
            _itemMenu(
              context,
              "Snack Box #1", 
              "Risol Mayo, Cupcake, & Jasuke", 
              'assets/images/top-view-chicken-nuggets-with-sauce.jpg',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SnackBoxMenu(
                menuName: "Snack Box #1", menuPrice: 14000,
                menuDesc: "Risol Mayo, Cupcake, & Jasuke",
                menuImg: 'assets/images/top-view-chicken-nuggets-with-sauce.jpg',
              ))),
            ),
            const SizedBox(height: 30),

            // Snack Box #2
            _itemMenu(
              context,
              "Snack Box #2", 
              "Buras, Sosis Solo, & Kue Sus", 
              'assets/images/unnamed.jpg', 
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SnackBoxMenu(
                menuName: "Snack Box #2", menuPrice: 13000,
                menuDesc: "Buras, Sosis Solo, & Kue Sus",
                menuImg: 'assets/images/unnamed.jpg',
              ))),
            ),
            const SizedBox(height: 30),

            // Snack Box #3
            _itemMenu(
              context,
              "Snack Box #3", 
              "Samosa Beef, Onde-onde & Ketan Abon", 
              'assets/images/delicious-pakistani-food-with-tomato-sauce.jpg', 
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SnackBoxMenu(
                menuName: "Snack Box #3", menuPrice: 15000,
                menuDesc: "Samosa Beef, Onde-onde & Ketan Abon",
                menuImg: 'assets/images/delicious-pakistani-food-with-tomato-sauce.jpg',
              ))),
            ),
            const SizedBox(height: 30),

            // Snack Box #4
            _itemMenu(
              context,
              "Snack Box #4", 
              "Pastel, Kue Lapis, & Pie Susu", 
              'assets/images/tips-membuat-pastel-renyah-dan-m-20231124031803-2291788294.webp', 
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SnackBoxMenu(
                menuName: "Snack Box #4", menuPrice: 12000,
                menuDesc: "Pastel, Kue Lapis, & Pie Susu",
                menuImg: 'assets/images/tips-membuat-pastel-renyah-dan-m-20231124031803-2291788294.webp',
              ))),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Widget Helper biar tampilan konsisten
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
        
        InkWell(
          onTap: tap,
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