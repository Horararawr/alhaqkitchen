import 'package:flutter/material.dart';
import 'package:alhaqkitchen/database/firebase_service.dart';
import 'package:alhaqkitchen/views/login/loginhaq.dart';
import 'package:alhaqkitchen/views/profile/settingshaq.dart';

class ProfileHaq extends StatefulWidget {
  final String userEmail;
  final String userName;
  const ProfileHaq({super.key, required this.userEmail, required this.userName});

  @override
  State<ProfileHaq> createState() => _ProfileHaqState();
}

class _ProfileHaqState extends State<ProfileHaq> {
  late String _userName;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await FirebaseService.getProfile();
    if (data != null && mounted) {
      setState(() {
        _userName = data['name'] ?? widget.userName;
        _imagePath = data['foto'];
      });
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
                backgroundImage: (_imagePath != null && _imagePath!.isNotEmpty)
                    ? NetworkImage(_imagePath!) as ImageProvider : null,
                child: (_imagePath == null || _imagePath!.isEmpty)
                    ? const Icon(Icons.person, size: 60, color: Colors.white) : null,
              ),
              const SizedBox(height: 15),
              // NAMA USER
              Text(_userName, 
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'BacasimeAntique', color: Colors.white, fontSize: 24)),
              // EMAIL USER (DIBAWAH NAMA)
              Text(widget.userEmail, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              
              const Divider(color: Color(0xFFBC9C22), thickness: 1, height: 30),
              
              _btn("Settings", Colors.transparent, () async {
                final result = await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => SettingsHaq(email: widget.userEmail, currentName: _userName))
                );
                if (result == true) _loadUserData(); // Refresh pas balik
              }),
              
              const SizedBox(height: 10),
              _btn("Logout", const Color(0xFFBA1212), () async {
                await FirebaseService.logoutUser();
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginHaq()), (r) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(String t, Color c, VoidCallback f) => SizedBox(
    width: double.infinity, height: 45, 
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: c, 
        side: c == Colors.transparent ? const BorderSide(color: Color(0xFFBC9C22)) : null, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ), 
      onPressed: f, 
      child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
    )
  );
}