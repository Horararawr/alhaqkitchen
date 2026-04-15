import 'package:flutter/material.dart';
import 'package:alhaqkitchen/database/firebase_service.dart';

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

  void _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final data = await FirebaseService.getRequestOrders();
      setState(() {
        _requests = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Error Refresh Data: $e");
      setState(() => _isLoading = false);
    }
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF00357A),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFBC9C22)),
            borderRadius: BorderRadius.circular(15)),
        title: const Text("Hapus Request?", 
            style: TextStyle(color: Color(0xFFBC9C22), fontFamily: 'BacasimeAntique')),
        content: const Text("Yakin mau hapus ini? Data yang dihapus nggak bisa balik lagi loh.", 
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("BATAL", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              _deleteRequest(id);
              Navigator.pop(context);
            },
            child: const Text("HAPUS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showForm(String? id, String? currentText) {
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
          autofocus: true, 
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
                    await FirebaseService.addRequestOrder(input);
                  } else {
                    await FirebaseService.updateRequestOrder(id, input);
                  }
                  _controller.clear();
                  Navigator.pop(context); 
                  _refreshData(); 
                } catch (e) {
                  print("Gagal Simpan ke Firebase: $e");
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

  void _deleteRequest(String id) async {
    await FirebaseService.deleteRequestOrder(id);
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
                      style: TextStyle(color: Colors.white54, fontSize: 16)))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final item = _requests[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFBC9C22), width: 0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          item['content'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_note_rounded, color: Colors.blueAccent, size: 28),
                              onPressed: () => _showForm(item['id'], item['content']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent, size: 28),
                              onPressed: () => _confirmDelete(item['id']),
                            ),
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