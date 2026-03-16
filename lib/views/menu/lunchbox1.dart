import 'package:alhaqkitchen/views/order/success_order.dart';
import 'package:flutter/material.dart';
import 'package:alhaqkitchen/database/sqflite.dart';
import 'package:alhaqkitchen/database/app_data.dart';

class LunchBox1 extends StatefulWidget {
  const LunchBox1({super.key});

  @override
  State<LunchBox1> createState() => _LunchBox1State();
}

class _LunchBox1State extends State<LunchBox1> {
  int _quantity = 1;
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String menuName = "Lunch Box #1";
    const int menuPrice = 20000;
    const String menuDesc = "Ayam Teriyaki, Nasi Putih, & Salad Mayo";
    const String menuImg = 'assets/images/teriyaki-chicken-with-rice-fresh-herbs-beige-plate-traditional-japanese-dish-side-view-close-up_166116-4589.jpg';

    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: Stack(
        children: [
          // 1. CONTENT SCROLLABLE
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: const Color(0xFF00357A),
                automaticallyImplyLeading: false, // Matiin back button bawaan
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(menuImg, fit: BoxFit.cover),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul dan Harga
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(menuName, 
                            style: TextStyle(color: Color(0xFFBC9C22), fontSize: 32, fontFamily: 'BacasimeAntique', fontWeight: FontWeight.bold)),
                          Text("Rp $menuPrice", 
                            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(menuDesc, 
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.white24),
                      ),

                      // Bagian Qty (Counter)
                      const Text("Jumlah Pesanan", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildQtyBtn(Icons.remove, () {
                            if (_quantity > 1) setState(() => _quantity--);
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("$_quantity", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          _buildQtyBtn(Icons.add, () => setState(() => _quantity++)),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Bagian Notes (Alamat & Request)
                      const Text("Catatan Tambahan (Opsional)", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _noteController,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Contoh: Alamat pengiriman, Jam kirim, atau Request (Gak pake mayo, dll)...",
                          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 120), // Spasi ekstra biar gak ketutup tombol bawah
                    ],
                  ),
                ),
              )
            ],
          ),

          // 2. TOMBOL BACK KUSTOM (Lingkaran Emas)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFBC9C22), // Warna emas request lo
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),

      // 3. TOMBOL ADD TO CART (Melayang di bawah)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF00357A),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBC9C22), 
            minimumSize: const Size(double.infinity, 55), 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
          ),
          onPressed: () => _order(context, menuName, menuPrice, menuDesc, menuImg),
          child: Text("Tambah ke Cart - Rp ${menuPrice * _quantity}", 
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBC9C22)),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Icon(icon, color: const Color(0xFFBC9C22), size: 20),
      ),
    );
  }

  void _order(BuildContext context, String name, int price, String desc, String img) async {
    await DBHelper.insertCartItem({
      'name': name, 
      'price': price, 
      'image': img, 
      'quantity': _quantity, 
      'status': 'cart', 
      'order_date': DateTime.now().toString(),
      'notes': _noteController.text 
    });
    
    globalCart.add(CartItem(
      name: name, 
      price: price, 
      desc: desc, 
      image: img, 
      qty: _quantity,
      notes: _noteController.text
    ));
    
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessOrder()));
  }
}