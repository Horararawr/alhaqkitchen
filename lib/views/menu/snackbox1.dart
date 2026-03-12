// import 'package:flutter/material.dart';
// import 'package:alhaqkitchen/database/app_data.dart';
// import 'package:alhaqkitchen/views/order/success_order.dart';

// class SnackBox1 extends StatefulWidget {
//   const SnackBox1({super.key});

//   @override
//   State<SnackBox1> createState() => _SnackBox1State();
// }

// class _SnackBox1State extends State<SnackBox1> {
//   int basePrice = 35000;
//   int qty = 1;
//   TextEditingController descC = TextEditingController(text: "Any else?");

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Color(0xFF00357A),
//       appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: IconThemeData(color: Color(0xFFBC9C22))),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//              Text("Detail Menu", style: TextStyle(color: Color(0xFFBC9C22), fontSize: 24)),
//              SizedBox(height: 20),
//             Text(widget.menuName, style: TextStyle(color: Colors.white, fontSize: 20)),
//              SizedBox(height: 10),
//             Text("Rp ${basePrice * qty}", style: TextStyle(color: Color(0xFFBC9C22), fontSize: 22, fontWeight: FontWeight.bold)),
//              SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(onPressed: () => setState(() => qty > 1 ? qty-- : null), icon: Icon(Icons.remove_circle, color: Colors.red)),
//                 Text("$qty", style: TextStyle(color: Colors.white, fontSize: 20)),
//                 IconButton(onPressed: () => setState(() => qty++), icon: Icon(Icons.add_circle, color: Colors.green)),
//               ],
//             ),
//             TextField(controller: descC, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Description", labelStyle: TextStyle(color: Colors.white70))),
//              SizedBox(height: 40),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 50)),
//               onPressed: () {
//                 globalCart.add(CartItem(name: widget.menuName, price: basePrice * qty, desc: descC.text));
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessOrder()));
//               },
//               child: Text("ORDER NOW"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }