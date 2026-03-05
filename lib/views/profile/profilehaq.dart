import 'dart:ui';
import 'package:alhaqkitchen/views/loginhaq.dart';
import 'package:flutter/material.dart';

class ProfileHaq extends StatelessWidget {
  const ProfileHaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: const Color(0xFF00357A))),
        Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: 300, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF004E92), borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(radius: 40, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 50, color: Colors.white)),
                  const SizedBox(height: 15),
                  const Text("Guest", style: TextStyle(fontFamily: 'BacasimeAntique', color: Colors.white, fontSize: 22)),
                  const Divider(color: Colors.white54),
                  _actionBtn("Settings", Colors.transparent, () {}),
                  const SizedBox(height: 10),
                  _actionBtn("Logout", const Color(0xFFBA1212), () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginHaq()), (r) => false);
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionBtn(String label, Color bg, VoidCallback tap) {
    return SizedBox(width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bg, side: bg == Colors.transparent ? const BorderSide(color: Color(0xFFBC9C22)) : null),
        onPressed: tap, child: Text(label, style: const TextStyle(color: Colors.white))));
  }
}