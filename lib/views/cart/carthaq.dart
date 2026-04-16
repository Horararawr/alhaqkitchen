import 'package:alhaqkitchen/models/cart_model.dart';
import 'package:alhaqkitchen/database/firebase_service.dart';
import 'package:flutter/material.dart';

class CartHaq extends StatefulWidget {
  const CartHaq({super.key});

  @override
  State<CartHaq> createState() => _CartHaqState();
}

class _CartHaqState extends State<CartHaq> {
  List<CartItem> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshCart();
  }

  Future<void> _refreshCart() async {
    setState(() => _isLoading = true);
    try {
      final items = await FirebaseService.getCartItems();
      setState(() {
        _cartItems = items;
        _isLoading = false;
      });
    } catch (e) {
      print("Error refresh cart: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            "Cart", 
            style: TextStyle(
              fontFamily: 'BacasimeAntique', 
              color: Color(0xFFBC9C22), 
              fontSize: 35
            )
          ),
          const Divider(color: Color(0xFFBC9C22)),
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator(color: Color(0xFFBC9C22)))
              : _cartItems.isEmpty 
                  ? const Center(
                      child: Text(
                        "Cart is empty", 
                        style: TextStyle(color: Colors.white70)
                      )
                    )
                  : ListView.builder(
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return Card(
                          color: const Color(0xFF004E92),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: item.image.startsWith('assets/') 
                                ? Image.asset(item.image, width: 60, height: 60, fit: BoxFit.cover)
                                : Image.network(item.image, width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, color: Colors.white60)),
                            ),
                            title: Text(
                              item.name, 
                              style: const TextStyle(
                                color: Colors.white, 
                                fontWeight: FontWeight.bold
                              )
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  "Rp ${item.price} - ${item.desc}", 
                                  style: const TextStyle(color: Colors.white70, fontSize: 13)
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.location_on, size: 14, color: Color(0xFFBC9C22)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          item.notes.isEmpty 
                                              ? "Tambah Alamat, Jam Kirim, atau Catatan" 
                                              : item.notes,
                                          style: TextStyle(
                                            color: item.notes.isEmpty ? Colors.white38 : Colors.white,
                                            fontSize: 12,
                                            fontStyle: item.notes.isEmpty ? FontStyle.italic : FontStyle.normal
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_note, color: Colors.white), 
                                  onPressed: () => _editDeliveryDetails(index)
                                ),  
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent), 
                                  onPressed: () => _confirmDelete(index)
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
          
          if (_cartItems.isNotEmpty) 
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC9C22),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  try {
                    await FirebaseService.checkout(_cartItems);
                    await _refreshCart();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Pesanan Selesai! Cek di Latest Order."),
                        backgroundColor: Color(0xFFBC9C22),
                      )
                    );
                  } catch (e) {
                    print("Checkout error: $e");
                    setState(() => _isLoading = false);
                  }
                }, 
                child: const Text(
                  "Selesai & Bayar", 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF00357A),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFBC9C22)),
            borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Hapus Pesanan?", 
          style: TextStyle(color: Color(0xFFBC9C22), fontWeight: FontWeight.bold, fontFamily: 'BacasimeAntique')
        ),
        content: Text(
          "Yakin mau hapus '${_cartItems[index].name}' dari keranjang?", 
          style: const TextStyle(color: Colors.white70)
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Batal", style: TextStyle(color: Colors.white70))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            ),
            onPressed: () async {
              Navigator.pop(context);
              setState(() => _isLoading = true);
              try {
                await FirebaseService.deleteCartItem(_cartItems[index].id);
                await _refreshCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pesanan dihapus"), 
                    backgroundColor: Color(0xFFBC9C22),
                    duration: Duration(seconds: 1)
                  )
                );
              } catch (e) {
                print("Delete error: $e");
                setState(() => _isLoading = false);
              }
            }, 
            child: const Text("Hapus", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }

  void _editDeliveryDetails(int index) {
    TextEditingController notesC = TextEditingController(text: _cartItems[index].notes);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF00357A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Detail Pengiriman & Catatan", 
          style: TextStyle(color: Color(0xFFBC9C22), fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pesanan: ${_cartItems[index].name}", style: const TextStyle(color: Colors.white60, fontSize: 13)),
            const SizedBox(height: 15),
            TextField(
              controller: notesC, 
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Masukkan Alamat, Jam Pengiriman, dan Catatan...",
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFBC9C22)),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFBC9C22), width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Batal", style: TextStyle(color: Colors.white70))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBC9C22),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            ),
            onPressed: () async {
              Navigator.pop(context);
              setState(() => _isLoading = true);
              try {
                await FirebaseService.updateCartItemNotes(_cartItems[index].id, notesC.text);
                await _refreshCart();
              } catch (e) {
                print("Update notes error: $e");
                setState(() => _isLoading = false);
              }
            }, 
            child: const Text("Simpan", style: TextStyle(color: Colors.white))
          )
        ],
      ),
    );
  }
}