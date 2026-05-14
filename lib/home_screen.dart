import 'package:flutter_application_1/detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Tugas 4: menerima daftar dari MainHome
  final List<Map<String, String>> daftarMahasiswa;

  const HomeScreen({super.key, required this.daftarMahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎓 StudentApp',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Ringkasan Statistik ──
            const Text(
              'Ringkasan Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    label: 'Total Mahasiswa',
                    value: '${daftarMahasiswa.length}',
                    icon: Icons.groups,
                    color: const Color(0xFF00695C),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    label: 'Status Aktif',
                    value: '${daftarMahasiswa.length}',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Daftar Mahasiswa ──
            const Text(
              'Daftar Mahasiswa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            daftarMahasiswa.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox, size: 64, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'Belum ada data mahasiswa',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Tambah via tab Daftar',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: daftarMahasiswa.length,
                      itemBuilder: (context, index) {
                        final mhs = daftarMahasiswa[index];
                        return _buildMahasiswaCard(
                          context: context,
                          nama: mhs['nama']!,
                          nim: mhs['nim']!,
                          jurusan: mhs['jurusan']!,
                          mahasiswa: mhs,
                          index: index,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMahasiswaCard({
    required BuildContext context,
    required String nama,
    required String nim,
    required String jurusan,
    required Map<String, String> mahasiswa,
    required int index,
  }) {
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[index % colors.length],
          child: Text(
            nama[0],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(nama, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('NIM: $nim  ·  $jurusan'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        // Tugas 3: navigasi ke DetailScreen
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(mahasiswa: mahasiswa),
            ),
          );
        },
      ),
    );
  }
}
