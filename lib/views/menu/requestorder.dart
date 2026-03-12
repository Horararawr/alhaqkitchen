import 'package:flutter/material.dart';
import 'package:alhaqkitchen/database/sqflite.dart'; // Pastiin path ini bener

class RequestOrder extends StatefulWidget {
  const RequestOrder({super.key});

  @override
  State<RequestOrder> createState() => _RequestOrderState();
}

class _RequestOrderState extends State<RequestOrder> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  // READ: Ambil data dari database
  void _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final data = await DBHelper.getData('request_orders');
      setState(() {
        _requests = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Error Refresh Data: $e");
      setState(() => _isLoading = false);
    }
  }

  // CREATE & UPDATE: Tampilkan Dialog
  void _showForm(int? id, String? currentText) {
    if (id != null) {
      _controller.text = currentText!;
    } else {
      _controller.clear();
    }

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF00357A),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFBC9C22)),
            borderRadius: BorderRadius.circular(15)),
        title: Text(id == null ? "Buat Request Baru" : "Edit Request",
            style: const TextStyle(
                color: Color(0xFFBC9C22), fontFamily: 'BacasimeAntique')),
        content: TextField(
          controller: _controller,
          maxLines: 4,
          autofocus: true, // Biar langsung ngetik
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Contoh: saya mau ayam kentucky 20pcs untuk jam 4 sore..",
            hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBC9C22))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBC9C22), width: 2)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.pop(context);
            },
            child: const Text("BATAL", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBC9C22)),
            onPressed: () async {
              final input = _controller.text.trim();
              if (input.isNotEmpty) {
                try {
                  if (id == null) {
                    // Simpan Data Baru
                    await DBHelper.insert('request_orders', {'content': input});
                  } else {
                    // Update Data Lama
                    await DBHelper.update('request_orders', id, {'content': input});
                  }
                  _controller.clear();
                  Navigator.pop(context); // Tutup Dialog
                  _refreshData(); // Refresh list di halaman utama
                } catch (e) {
                  print("Gagal Simpan ke DB: $e");
                }
              }
            },
            child: const Text("ENTER",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // DELETE
  void _deleteRequest(int id) async {
    await DBHelper.delete('request_orders', id);
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFBC9C22)),
        title: const Text(
          "Request Order",
          style: TextStyle(
            fontFamily: 'BacasimeAntique',
            color: Color(0xFFBC9C22),
            fontSize: 30,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                color: const Color(0xFFBC9C22),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFBC9C22)))
          : _requests.isEmpty
              ? const Center(
                  child: Text("Belum ada request...",
                      style: TextStyle(color: Colors.white54)))
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final item = _requests[index];
                    return Card(
                      color: Colors.white.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                              color: Color(0xFFBC9C22), width: 0.5)),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        title: Text(item['content'] ?? '',
                            style: const TextStyle(color: Colors.white, fontSize: 16)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                onPressed: () => _showForm(item['id'], item['content'])),
                            IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () => _deleteRequest(item['id'])),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFBC9C22),
        onPressed: () => _showForm(null, null),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}