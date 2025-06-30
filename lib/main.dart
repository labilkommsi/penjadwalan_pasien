import 'package:flutter/material.dart';
import 'package:penjadwalan_pasien/screens/login_screen.dart'; // Import file login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penjadwalan Pasien',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Atur warna tema utama aplikasi
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: const LoginScreen(), // Halaman pertama yang dibuka adalah LoginScreen
    );
  }
}