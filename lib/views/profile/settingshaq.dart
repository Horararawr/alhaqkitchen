import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alhaqkitchen/database/firebase_service.dart';

class SettingsHaq extends StatefulWidget {
  final String email;
  final String currentName;
  const SettingsHaq({super.key, required this.email, required this.currentName});

  @override
  State<SettingsHaq> createState() => _SettingsHaqState();
}

class _SettingsHaqState extends State<SettingsHaq> {
  late TextEditingController _nameController;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false; // Biar lo tau proses lagi jalan

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    final data = await FirebaseService.getProfile();
    if (data != null && data['foto'] != null && data['foto'].isNotEmpty) {
      setState(() {
        _photoUrl = data['foto'];
      });
    }
  }

  String? _photoUrl;

  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) setState(() {
      _image = File(file.path);
      _photoUrl = null; // Clear URL if local image is picked
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00357A),
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[400],
                    backgroundImage: _image != null 
                        ? FileImage(_image!) 
                        : (_photoUrl != null && _photoUrl!.isNotEmpty ? NetworkImage(_photoUrl!) as ImageProvider : null),
                    child: (_image == null && (_photoUrl == null || _photoUrl!.isEmpty)) ? const Icon(Icons.camera_alt, size: 40, color: Colors.white) : null,
                  ),
                  Positioned(
                    bottom: 0, right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Color(0xFFBC9C22), shape: BoxShape.circle),
                      child: const Icon(Icons.edit, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: const TextStyle(color: Color(0xFFBC9C22)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white54), borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBC9C22)), borderRadius: BorderRadius.circular(10))
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC9C22),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: _isLoading ? null : () async {
                  if (_nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nama tidak boleh kosong!")));
                    return;
                  }
                  
                  setState(() => _isLoading = true);
                  
                  try {
                    // 1. Update Profile Name
                    await FirebaseService.updateProfileName(_nameController.text.trim());

                    // 2. Update Image if selected
                    if (_image != null) {
                      await FirebaseService.updateProfilePhoto(_image!);
                    }

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profil berhasil diperbarui di Firebase!"))
                      );
                      // Back with 'true' to trigger refresh in ProfileHaq
                      Navigator.pop(context, true);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Gagal Simpan: $e"), backgroundColor: Colors.red)
                      );
                    }
                  } finally {
                    if (mounted) setState(() => _isLoading = false);
                  }
                },
                child: _isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("SIMPAN PERUBAHAN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}