import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  //Tugas 4: callback untuk kirim data ke MainHome
  final void Function(Map<String, String> mahasiswa) onSimpan;

  const FormScreen({super.key, required this.onSimpan});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _teleponController = TextEditingController();

  // Tugas 2: dropdown jurusan
  final List<String> _jurusanList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Manajemen Informatika',
    'Teknik Komputer',
    'Ilmu Komputer',
  ];
  String? _selectedJurusan;

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      //Tugas 4: kirim data ke MainHome via callback
      widget.onSimpan({
        'nama': _namaController.text,
        'nim': _nimController.text,
        'email': _emailController.text,
        'jurusan': _selectedJurusan!,
        'telepon': _teleponController.text,
      });

      // Tampilkan snackbar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data ${_namaController.text} berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );

      _resetForm();
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _nimController.clear();
    _emailController.clear();
    _teleponController.clear();
    setState(() {
      _selectedJurusan = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📝 Pendaftaran Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Card(
                color: Color(0xFFE3F2FD),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: const Color(0xFF00695C)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Isi semua field yang bertanda * (wajib diisi)',
                          style: TextStyle(color: const Color(0xFF00695C)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _namaController,
                label: 'Nama Lengkap *',
                hint: 'Contoh: Andi Pratama',
                icon: Icons.person,
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'Nama tidak boleh kosong';
                  if (val.length < 3) return 'Nama minimal 3 karakter';
                  return null;
                },
              ),

              //(Tugas 1: hanya angka)
              _buildTextField(
                controller: _nimController,
                label: 'NIM *',
                hint: 'Contoh: 2021001',
                icon: Icons.badge,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'NIM tidak boleh kosong';
                  if (val.length < 5) return 'NIM minimal 5 digit';
                  // Tugas 1: validasi hanya angka
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return 'NIM hanya boleh berisi angka';
                  }
                  return null;
                },
              ),

              // Field EMAIL
              _buildTextField(
                controller: _emailController,
                label: 'Email *',
                hint: 'Contoh: andi@mahasiswa.ac.id',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'Email tidak boleh kosong';
                  if (!val.contains('@') || !val.contains('.')) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),

              // tugas 2: Dropdown JURUSAN
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DropdownButtonFormField<String>(
                  value: _selectedJurusan,
                  decoration: const InputDecoration(
                    labelText: 'Jurusan *',
                    prefixIcon: Icon(Icons.school),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF00695C),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  hint: const Text('Pilih Jurusan'),
                  items: _jurusanList.map((jurusan) {
                    return DropdownMenuItem<String>(
                      value: jurusan,
                      child: Text(jurusan),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedJurusan = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return 'Jurusan harus dipilih';
                    return null;
                  },
                ),
              ),

              _buildTextField(
                controller: _teleponController,
                label: 'No. Telepon (Opsional)',
                hint: 'Contoh: 08123456789',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: null,
              ),
              const SizedBox(height: 24),

              // Tombol SIMPAN
              ElevatedButton.icon(
                onPressed: _simpanData,
                icon: const Icon(Icons.save),
                label: const Text(
                  'SIMPAN DATA',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00695C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 8),

              // ── Tombol RESET ─────────────────────────
              OutlinedButton.icon(
                onPressed: _resetForm,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF00695C), width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
