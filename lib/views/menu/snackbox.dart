import 'package:flutter/material.dart';
// import 'snackbox2.dart';
// import 'snackbox3.dart';
// import 'snackbox4.dart';

class SnackBox extends StatelessWidget {
  const SnackBox({super.key});

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
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SnackBox1(menuName: "SnackBox1"))),
            // child: Container(
            //   decoration: BoxDecoration(border: Border.all(color: const Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(15)),
            //   child: Center(child: Text("Menu ${index + 1}", style: const TextStyle(color: Colors.white))),
            // ),
          );
        }, 
      ),
    );
  }
}