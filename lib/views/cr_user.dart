import 'package:alhaqkitchen/database/preference.dart';
import 'package:alhaqkitchen/views/loginhaq.dart';
import 'package:alhaqkitchen/extension/navigatorhaq.dart';
import 'package:flutter/material.dart';

class CrUser extends StatefulWidget {
  const CrUser ({super.key});

  @override
  State<CrUser> createState() => _CrUserState();
}

class _CrUserState extends State<CrUser> {

  void _logout() async {
    await PreferenceHandler().deleteIsLogin();
    if (mounted) context.pushAndRemoveAll(const LoginHaq());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesanan Al-Haq Kitchen"),
        backgroundColor: const Color(0xFFC6A664),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            
          )
        )
      )
    );
  }
}