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
          const Text("Cart", style: TextStyle(fontFamily: 'BacasimeAntique', color: Color(0xFFBC9C22), fontSize: 35)),
          const Divider(color: Color(0xFFBC9C22)),
          Expanded(
            child: globalCart.isEmpty 
              ? const Center(child: Text("Cart is empty", style: TextStyle(color: Colors.white70)))
              : ListView.builder(
                  itemCount: globalCart.length,
                  itemBuilder: (context, index) {
                    final item = globalCart[index];
                    return Card(
                      color: const Color(0xFF004E92),
                      child: ListTile(
                        title: Text(item.name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text("${item.price} - ${item.desc}", style: const TextStyle(color: Colors.white70)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // EDIT (UPDATE)
                            IconButton(icon: const Icon(Icons.edit, color: Colors.white), onPressed: () => _editItem(index)),
                            // TRASH (DELETE)
                            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
                              setState(() => globalCart.removeAt(index));
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  void _editItem(int index) {
    TextEditingController editC = TextEditingController(text: globalCart[index].desc);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Description"),
        content: TextField(controller: editC),
        actions: [
          TextButton(onPressed: () {
            setState(() => globalCart[index].desc = editC.text);
            Navigator.pop(context);
          }, child: const Text("Save"))
        ],
      ),
    );
  }
}