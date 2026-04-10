import 'package:alhaqkitchen/models/cart_model.dart';
import 'package:alhaqkitchen/views/lunchbox/lunchboxmenu.dart';
import 'package:alhaqkitchen/views/snackbox/snackboxmenu.dart';
import 'package:flutter/material.dart';

class LatestOrder extends StatefulWidget {
  const LatestOrder({super.key});

  @override
  State<LatestOrder> createState() => _LatestOrderState();
}

class _LatestOrderState extends State<LatestOrder> {
  // Data menu untuk navigasi "Order Again"
  static const _lunchBoxData = {
    "#1": {"name": "Lunch Box #1", "price": 20000, "desc": "Ayam Teriyaki, Nasi Putih, & Salad Mayo", "img": "assets/images/teriyaki-chicken-with-rice-fresh-herbs-beige-plate-traditional-japanese-dish-side-view-close-up_166116-4589.jpg"},
    "#2": {"name": "Lunch Box #2", "price": 25000, "desc": "Beef Teriyaki, Nasi Putih, & Salad Mayo", "img": "assets/images/instant-pot-teriyaki-beef-recipe.webp"},
    "#3": {"name": "Lunch Box #3", "price": 25000, "desc": "Ayam Briyani, Nasi Brasmati, & Kentang", "img": "assets/images/plate-biryani-with-bunch-food-it.jpg"},
    "#4": {"name": "Lunch Box #4", "price": 20000, "desc": "Beef Rendang, Nasi Putih, & Telor Bulet", "img": "assets/images/Beef-Rendang-Indonesian-Curry-sw.jpg"},
  };

  static const _snackBoxData = {
    "#1": {"name": "Snack Box #1", "price": 14000, "desc": "Risol Mayo, Cupcake, & Jasuke", "img": "assets/images/top-view-chicken-nuggets-with-sauce.jpg"},
    "#2": {"name": "Snack Box #2", "price": 13000, "desc": "Buras, Sosis Solo, & Kue Sus", "img": "assets/images/unnamed.jpg"},
    "#3": {"name": "Snack Box #3", "price": 15000, "desc": "Samosa Beef, Onde-onde & Ketan Abon", "img": "assets/images/delicious-pakistani-food-with-tomato-sauce.jpg"},
    "#4": {"name": "Snack Box #4", "price": 12000, "desc": "Pastel, Kue Lapis, & Pie Susu", "img": "assets/images/tips-membuat-pastel-renyah-dan-m-20231124031803-2291788294.webp"},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A), // Tema Biru Al-Haq
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFBC9C22)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Latest Order",
          style: TextStyle(
            fontFamily: 'BacasimeAntique',
            color: Color(0xFFBC9C22),
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        // --- STRIPE DIVIDER DI BAWAH TULISAN LATEST ORDER ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), // Jarak kanan kiri garis
            child: Container(
              height: 1.5, // Ketebalan garis
              decoration: BoxDecoration(
                color: const Color(0xFFBC9C22),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBC9C22).withOpacity(0.1),
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: globalHistory.isEmpty
          ? const Center(
              child: Text(
                "No history yet",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              itemCount: globalHistory.length,
              itemBuilder: (context, index) {
                final item = globalHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: const Color(0xFFBC9C22).withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: Color(0xFFBC9C22),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.date ?? "",
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.desc,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Qty: ${item.qty}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(color: Colors.white24, height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBC9C22),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () => _handleOrderAgain(item.name),
                          child: const Text(
                            "Order Again?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }

  // LOGIK NAVIGASI BALIK KE MENU SPESIFIK
  void _handleOrderAgain(String name) {
    Widget? targetPage;

    // Cari nomor menu dari nama
    for (final key in ["#1", "#2", "#3", "#4"]) {
      if (name.contains(key)) {
        if (name.toLowerCase().contains("lunch")) {
          final data = _lunchBoxData[key]!;
          targetPage = LunchBoxMenu(
            menuName: data["name"] as String,
            menuPrice: data["price"] as int,
            menuDesc: data["desc"] as String,
            menuImg: data["img"] as String,
          );
        } else if (name.toLowerCase().contains("snack")) {
          final data = _snackBoxData[key]!;
          targetPage = SnackBoxMenu(
            menuName: data["name"] as String,
            menuPrice: data["price"] as int,
            menuDesc: data["desc"] as String,
            menuImg: data["img"] as String,
          );
        }
        break;
      }
    }

    if (targetPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage!),
      );
    }
  }
}