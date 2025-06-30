import 'package:flutter/material.dart';
import 'package:penjadwalan_pasien/screens/splash_screen.dart'; // Import splash screen

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
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // Jadikan SplashScreen sebagai halaman pertama
      home: const SplashScreen(),
    );
  }
}