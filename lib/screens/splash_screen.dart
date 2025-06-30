import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penjadwalan_pasien/screens/home_screen.dart';
import 'package:penjadwalan_pasien/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Memulai proses pengecekan setelah frame pertama selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    // Memberi jeda 2 detik untuk menampilkan splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Mendapatkan instance dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Mengecek apakah ada nilai untuk 'isLoggedIn', jika tidak ada, anggap false
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Navigasi berdasarkan status login
    if (mounted) { // Memastikan widget masih ada di tree sebelum navigasi
      if (isLoggedIn) {
        // Jika sudah login, arahkan ke HomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Jika belum login, arahkan ke LoginScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Anda bisa menambahkan logo di sini
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Memuat Aplikasi...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}