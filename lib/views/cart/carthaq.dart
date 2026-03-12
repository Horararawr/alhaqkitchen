import 'package:alhaqkitchen/database/app_data.dart';
import 'package:flutter/material.dart';

class CartHaq extends StatefulWidget {
  const CartHaq({super.key});

  @override
  State<CartHaq> createState() => _CartHaqState();
}

class _CartHaqState extends State<CartHaq> {
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
            child: globalCart.isEmpty 
              ? const Center(
                  child: Text(
                    "Cart is empty", 
                    style: TextStyle(color: Colors.white70)
                  )
                )
              : ListView.builder(
                  itemCount: globalCart.length,
                  itemBuilder: (context, index) {
                    final item = globalCart[index];
                    return Card(
                      color: const Color(0xFF004E92),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.image, 
                            width: 60, 
                            height: 60, 
                            fit: BoxFit.cover
                          ),
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
                            // TAMPILAN MENU (Statis, gak bakal keganti)
                            Text(
                              "Rp ${item.price} - ${item.desc}", 
                              style: const TextStyle(color: Colors.white70)
                            ),
                            const SizedBox(height: 5),
                            // TAMPILAN NOTES (Alamat/Jadwal)
                            Text(
                              item.notes.isEmpty 
                                  ? "Klik edit untuk tambah alamat/jadwal" 
                                  : "📍 ${item.notes}",
                              style: TextStyle(
                                color: item.notes.isEmpty ? Colors.white38 : const Color(0xFFBC9C22),
                                fontSize: 12,
                                fontStyle: item.notes.isEmpty ? FontStyle.italic : FontStyle.normal
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_note, color: Colors.white), 
                                  onPressed: () => _editDeliveryDetails(index)
                                ),  
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent), 
                                  onPressed: () {
                                    setState(() => globalCart.removeAt(index));
                                  }
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
          
          // TOMBOL SELESAI / CHECKOUT
          if (globalCart.isNotEmpty) 
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
                onPressed: () {
                  setState(() {
                    for (var item in globalCart) {
                      item.date = DateTime.now().toString().substring(0, 16);
                      globalHistory.add(item); 
                    }
                    globalCart.clear(); 
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pesanan Selesai! Cek di Latest Order."),
                      backgroundColor: Color(0xFFBC9C22),
                    )
                  );
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

  // FUNGSI EDIT KHUSUS ALAMAT & JADWAL
  void _editDeliveryDetails(int index) {
    // Ambil data dari notes, bukan desc
    TextEditingController notesC = TextEditingController(text: globalCart[index].notes);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF00357A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Detail Pengiriman", 
          style: TextStyle(color: Color(0xFFBC9C22))
        ),
        content: TextField(
          controller: notesC, 
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Contoh: Jl. Merdeka No. 10, Jam 1 Siang",
            hintStyle: TextStyle(color: Colors.white38),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFBC9C22))
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Batal", style: TextStyle(color: Colors.white70))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBC9C22)),
            onPressed: () {
              setState(() {
                // Simpan ke variabel notes, biar menu aman
                globalCart[index].notes = notesC.text;
              });
              Navigator.pop(context);
            }, 
            child: const Text("Simpan", style: TextStyle(color: Colors.white))
          )
        ],
      ),
    );
  }
}