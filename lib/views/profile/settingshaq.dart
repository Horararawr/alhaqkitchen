import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alhaqkitchen/database/sqflite.dart';

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
    final data = await DBHelper.getProfile(widget.email);
    if (data != null && data['foto'] != null && data['foto'].isNotEmpty) {
      final file = File(data['foto']);
      if (file.existsSync()) {
        setState(() => _image = file);
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) setState(() => _image = File(file.path));
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
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? const Icon(Icons.camera_alt, size: 40, color: Colors.white) : null,
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
                  setState(() => _isLoading = true);
                  
                  try {
                    // Update Database
                    await DBHelper.saveProfile(
                      widget.email, 
                      _nameController.text.trim(), 
                      _image?.path ?? "", 
                      "", // noHp
                      ""  // alamat
                    );

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Changes Saved!"))
                      );
                      // Navigator.pop ngirim 'true' biar ProfileHaq refresh
                      Navigator.pop(context, true);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e"))
                      );
                    }
                  } finally {
                    if (mounted) setState(() => _isLoading = false);
                  }
                },
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("SAVE CHANGES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}