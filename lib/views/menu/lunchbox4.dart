import 'package:flutter/material.dart';
import 'package:alhaqkitchen/database/sqflite.dart';
import 'package:alhaqkitchen/database/app_data.dart';
import 'package:alhaqkitchen/views/order/success_order.dart';

class LunchBox4 extends StatelessWidget {
  const LunchBox4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Color(0xFFBC9C22))),
      body: Column(
        children: [
          Image.asset('assets/images/db2be0683f97128e0d0b88fc5f30bfb4.jpg', height: 300, fit: BoxFit.cover, width: double.infinity),
          const SizedBox(height: 20),
          const Text("Lunch Box #4", style: TextStyle(color: Color(0xFFBC9C22), fontSize: 35, fontFamily: 'BonheurRoyale')),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Beef Rendang, Nasi Putih, & Telor Bulet", style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBC9C22), minimumSize: const Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: () => _order(context, "Lunch Box #4", 40000, "Beef Rendang, Nasi Putih, & Telor Bulet", 'assets/images/db2be0683f97128e0d0b88fc5f30bfb4.jpg'),
            child: const Text("Tambah ke Cart", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'BacasimeAntique')),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  void _order(BuildContext context, String name, int price, String desc, String img) async {
    await DBHelper.insertCartItem({'name': name, 'price': price, 'image': img, 'quantity': 1, 'status': 'cart', 'order_date': ''});
    globalCart.add(CartItem(name: name, price: price, desc: desc, image: img, qty: 1));
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessOrder()));
  }
}