import 'package:flutter_application_1/form_screen.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Rekap Data Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainHome(),
    );
  }
}

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _daftarMahasiswa = [
    {'nama': 'Andi Pratama', 'nim': '2021001', 'jurusan': 'Teknik Informatika'},
    {'nama': 'Budi Santoso', 'nim': '2021002', 'jurusan': 'Sistem Informasi'},
    {'nama': 'Citra Dewi', 'nim': '2021003', 'jurusan': 'Teknik Informatika'},
    {
      'nama': 'Dian Rahayu',
      'nim': '2021004',
      'jurusan': 'Manajemen Informatika',
    },
    {'nama': 'Eka Kurniawan', 'nim': '2021005', 'jurusan': 'Sistem Informasi'},
  ];

  void _tambahMahasiswa(Map<String, String> mahasiswa) {
    setState(() {
      _daftarMahasiswa.add(mahasiswa);
      _selectedIndex = 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(daftarMahasiswa: _daftarMahasiswa),
      FormScreen(onSimpan: _tambahMahasiswa),
      ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF00695C),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Daftar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
