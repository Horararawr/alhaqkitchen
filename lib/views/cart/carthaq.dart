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
                              onPressed: () => _confirmDelete(index) // <--- Panggil fungsi alert
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
          
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

  // --- FUNGSI BARU: ALERT KONFIRMASI HAPUS ---
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
          "Yakin mau hapus '${globalCart[index].name}' dari keranjang?", 
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
            onPressed: () {
              setState(() => globalCart.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Pesanan dihapus"), duration: Duration(seconds: 1))
              );
            }, 
            child: const Text("Hapus", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }

  // FUNGSI EDIT ALAMAT, WAKTU & CATATAN
  void _editDeliveryDetails(int index) {
    TextEditingController notesC = TextEditingController(text: globalCart[index].notes);
    
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
            Text("Pesanan: ${globalCart[index].name}", style: const TextStyle(color: Colors.white60, fontSize: 13)),
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
            onPressed: () {
              setState(() {
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