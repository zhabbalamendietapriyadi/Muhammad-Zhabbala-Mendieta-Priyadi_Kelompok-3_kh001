import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Key untuk validasi Form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil nilai dari TextFormField
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _mataKuliahController = TextEditingController();

  // Variabel untuk menyimpan pilihan status kehadiran (default: Hadir)
  String _statusKehadiran = 'Hadir';

  // State untuk indikator loading saat proses simpan
  bool _isLoading = false;

  @override
  void dispose() {
    // Membersihkan controller ketika widget di-dispose
    _namaController.dispose();
    _nimController.dispose();
    _lokasiController.dispose();
    _mataKuliahController.dispose();
    super.dispose();
  }

  // Fungsi dinamis untuk menyimpan data input pengguna ke Firestore
  Future<void> simpanData() async {
    await FirebaseFirestore.instance.collection('pertemuan5').add({
      'nama': _namaController.text.trim(),
      'nim': _nimController.text.trim(),
      'lokasi': _lokasiController.text.trim(),
      'mata_kuliah': _mataKuliahController.text.trim(),
      'status': _statusKehadiran,
      'waktu': FieldValue.serverTimestamp(),
    });
  }

  // Fungsi mereset seluruh nilai input form
  void _resetForm() {
    _namaController.clear();
    _nimController.clear();
    _lokasiController.clear();
    _mataKuliahController.clear();
    setState(() {
      _statusKehadiran = 'Hadir';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum Firebase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Field Input Nama
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field Input NIM
              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field Input Lokasi
              TextFormField(
                controller: _lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Lokasi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field Input Mata Kuliah
              TextFormField(
                controller: _mataKuliahController,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mata kuliah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field Keterangan Kehadiran (Dropdown)
              DropdownButtonFormField<String>(
                value: _statusKehadiran,
                decoration: const InputDecoration(
                  labelText: 'Keterangan Kehadiran',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.assignment_turned_in),
                ),
                items: const [
                  DropdownMenuItem(value: 'Hadir', child: Text('Hadir')),
                  DropdownMenuItem(value: 'Izin', child: Text('Izin')),
                  DropdownMenuItem(value: 'Sakit', child: Text('Sakit')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _statusKehadiran = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                  // 1. Validasi form input
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      // 2. Kirim data ke Cloud Firestore
                      await simpanData();

                      if (!mounted) return;

                      // 3. Tampilkan pesan sukses
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil dikirim!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // 4. Kosongkan kembali seluruh field input
                      _resetForm();
                    } catch (e) {
                      if (!mounted) return;

                      // 5. Tampilkan pesan error jika gagal
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal mengirim data: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } finally {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  }
                },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Simpan ke Firebase',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}