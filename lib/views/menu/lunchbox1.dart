import 'package:flutter/material.dart';
import 'package:alhaqkitchen/database/app_data.dart';
import 'package:alhaqkitchen/views/order/success_order.dart';

class LunchBox1 extends StatefulWidget {
  final String menuName;
  const LunchBox1({super.key, required this.menuName});

  @override
  State<LunchBox1> createState() => _LunchBox1State();
}

class _LunchBox1State extends State<LunchBox1> {
  int basePrice = 35000;
  int qty = 1;
  TextEditingController descC = TextEditingController(text: "No spicy please");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Color(0xFFBC9C22))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Detail Menu", style: TextStyle(color: Color(0xFFBC9C22), fontSize: 24)),
            const SizedBox(height: 20),
            Text(widget.menuName, style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 10),
            Text("Rp ${basePrice * qty}", style: const TextStyle(color: Color(0xFFBC9C22), fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () => setState(() => qty > 1 ? qty-- : null), icon: const Icon(Icons.remove_circle, color: Colors.red)),
                Text("$qty", style: const TextStyle(color: Colors.white, fontSize: 20)),
                IconButton(onPressed: () => setState(() => qty++), icon: const Icon(Icons.add_circle, color: Colors.green)),
              ],
            ),
            TextField(controller: descC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Description", labelStyle: TextStyle(color: Colors.white70))),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                globalCart.add(CartItem(name: widget.menuName, price: basePrice * qty, desc: descC.text));
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessOrder()));
              },
              child: const Text("ORDER NOW"),
            )
          ],
        ),
      ),
    );
  }
}