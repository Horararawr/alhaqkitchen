import 'dart:io';
import 'package:flutter/material.dart';
import 'package:alhaqkitchen/views/loginhaq.dart';
import 'package:alhaqkitchen/views/profile/settingshaq.dart'; 
import 'package:alhaqkitchen/database/sqflite.dart';

class ProfileHaq extends StatefulWidget {
  final String userEmail; 
  final String userName; // Ini nangkep lemparan dari Home
  const ProfileHaq({super.key, required this.userEmail, required this.userName});

  @override
  State<ProfileHaq> createState() => _ProfileHaqState();
}

class _ProfileHaqState extends State<ProfileHaq> {
  late String _userName; // Pakai late
  String? _imagePath;

  @override
  void initState() { 
    super.initState(); 
    _userName = widget.userName; // LANGSUNG ISI DISINI, NO LOADING!
    _loadUserData(); 
  }

  Future<void> _loadUserData() async {
    final data = await DBHelper.getProfile(widget.userEmail);
    if (data != null) {
      if (mounted) {
        setState(() {
          _userName = data['nama'] ?? widget.userName;
          _imagePath = data['foto']; 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      body: Center(
        child: Container(
          width: 320, padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFF004E92).withOpacity(0.7), 
            borderRadius: BorderRadius.circular(20), 
            border: Border.all(color: const Color(0xFFBC9C22).withOpacity(0.3))
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50, backgroundColor: Colors.grey,
                backgroundImage: (_imagePath != null && _imagePath!.isNotEmpty && File(_imagePath!).existsSync()) 
                    ? FileImage(File(_imagePath!)) : null,
                child: (_imagePath == null || _imagePath!.isEmpty || !File(_imagePath!).existsSync()) 
                    ? const Icon(Icons.person, size: 60, color: Colors.white) : null,
              ),
              const SizedBox(height: 15),
              Text(_userName, style: const TextStyle(fontFamily: 'BacasimeAntique', color: Colors.white, fontSize: 24)),
              Text(widget.userEmail, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const Divider(color: Color(0xFFBC9C22), thickness: 1, height: 30),
              _btn("Settings", Colors.transparent, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsHaq(email: widget.userEmail, currentName: _userName))).then((v) { if (v == true) _loadUserData(); })),
              const SizedBox(height: 10),
              _btn("Logout", const Color(0xFFBA1212), () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginHaq()), (r) => false)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(String t, Color c, VoidCallback f) => SizedBox(width: double.infinity, height: 45, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: c, side: c == Colors.transparent ? const BorderSide(color: Color(0xFFBC9C22)) : null, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: f, child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))));
}