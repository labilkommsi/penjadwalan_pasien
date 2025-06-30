import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Pasien'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Tambahkan fungsi logout
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Selamat Datang! Jadwal Anda akan tampil di sini.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}