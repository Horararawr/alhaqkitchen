import 'package:alhaqkitchen/models/cart_model.dart';
import 'package:alhaqkitchen/views/lunchbox/lunchbox1.dart';
import 'package:alhaqkitchen/views/lunchbox/lunchbox2.dart';
import 'package:alhaqkitchen/views/lunchbox/lunchbox3.dart';
import 'package:alhaqkitchen/views/lunchbox/lunchbox4.dart';
import 'package:flutter/material.dart';

class LatestOrder extends StatefulWidget {
  const LatestOrder({super.key});

  @override
  State<LatestOrder> createState() => _LatestOrderState();
}

class _LatestOrderState extends State<LatestOrder> {
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
    Widget targetPage;
    if (name.contains("#1")) {
      targetPage = const LunchBox1();
    } else if (name.contains("#2")) {
      targetPage = const LunchBox2();
    } else if (name.contains("#3")) {
      targetPage = const LunchBox3();
    } else {
      targetPage = const LunchBox4();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}