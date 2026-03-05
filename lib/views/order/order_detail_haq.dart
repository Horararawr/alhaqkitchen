import 'package:flutter/material.dart';

class OrderDetailHaq extends StatefulWidget {
  const OrderDetailHaq({super.key});

  @override
  State<OrderDetailHaq> createState() => _OrderDetailHaqState();
}

class _OrderDetailHaqState extends State<OrderDetailHaq> {
  int price = 35000;
  int extraPrice = 0;

  void updatePrice(bool add) {
    setState(() {
      if (add) {
        extraPrice += 5000;
      } else if (extraPrice > 0) {
        extraPrice -= 5000;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Color(0xFFBC9C22))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(height: 200, width: double.infinity, decoration: BoxDecoration(border: Border.all(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(15)), child: const Center(child: Text("Gambar Lunch Box #1", style: TextStyle(color: Colors.white)))),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Lunch Box #1", style: TextStyle(color: Color(0xFFBC9C22), fontSize: 20)),
              Text("${(price + extraPrice) ~/ 1000}k", style: const TextStyle(color: Color(0xFFBC9C22), fontSize: 20)),
            ]),
            const SizedBox(height: 20),
            _addOption("Air Putih 100ml (+5k)"),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => _showSuccess(context),
              child: const Text("Order Now"),
            )
          ],
        ),
      ),
    );
  }

  Widget _addOption(String label) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(color: Colors.white)),
      Row(children: [
        IconButton(onPressed: () => updatePrice(true), icon: const Icon(Icons.add_circle, color: Colors.green)),
        IconButton(onPressed: () => updatePrice(false), icon: const Icon(Icons.remove_circle, color: Colors.red)),
      ])
    ]);
  }

  void _showSuccess(BuildContext context) {
    showDialog(context: context, builder: (context) => const Center(child: Card(child: Padding(padding: EdgeInsets.all(20), child: Text("Order Berhasil! Cek Keranjang.")))));
    Future.delayed(const Duration(seconds: 3), () => Navigator.pop(context));
  }
}