import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penjadwalan_pasien/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel untuk menyimpan state
  bool _isLoading = true;
  List<dynamic> _jadwalList = [];

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi untuk mengambil data jadwal saat halaman pertama kali dibuka
    _fetchJadwal();
  }

  Future<void> _fetchJadwal() async {
    final prefs = await SharedPreferences.getInstance();
    // Ambil user_id yang sudah kita simpan saat login
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      // Jika karena suatu hal user_id tidak ada, kembali ke login
      _logout();
      return;
    }

    // Ganti dengan alamat IP Anda
    final url = Uri.parse('http://10.1.15.25/api_pasien_cerdas/ambil_jadwal.php?id_pengguna=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          setState(() {
            _jadwalList = responseData['data'];
            _isLoading = false;
          });
        } else {
          // Handle error jika status dari API bukan 'success'
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Gagal memuat data')),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan jaringan: ${e.toString()}')),
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Rutinitas Pasien'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _jadwalList.isEmpty
          ? const Center(
        child: Text(
          'Belum ada jadwal. Silakan tambahkan.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _jadwalList.length,
        itemBuilder: (context, index) {
          final jadwal = _jadwalList[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(
                Icons.alarm,
                color: Colors.teal,
                size: 40,
              ),
              title: Text(
                jadwal['nama_kegiatan'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Jadwal: Pukul ${jadwal['waktu_jadwal']}',
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Icon(
                Icons.check_circle_outline,
                color: jadwal['status'] == 'selesai'
                    ? Colors.green
                    : Colors.grey.shade400,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigasi ke halaman tambah jadwal
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Jadwal',
      ),
    );
  }
}