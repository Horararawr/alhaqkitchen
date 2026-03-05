import 'package:flutter/material.dart';
import 'lunchbox1.dart';

class LunchBox extends StatelessWidget {
  const LunchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Color(0xFFBC9C22))),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LunchBox1(menuName: "Lunch Box #${index + 1}"))),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text("Menu ${index + 1}", style: const TextStyle(color: Colors.white))),
            ),
          );
        },
      ),
    );
  }
}