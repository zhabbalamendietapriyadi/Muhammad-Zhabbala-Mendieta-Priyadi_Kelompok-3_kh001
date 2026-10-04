import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // Daftar halaman yang akan ditampilkan saat menu bawah diklik
  final List<Widget> pages = const [
    HomeContent(),
    FormRegistrasi(),
    HalamanTugas3(), // Menu untuk Tugas 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zhabbala App"),
      ),
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Tugas 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge),
            label: 'Tugas 3',
          ),
        ],
      ),
    );
  }
}

// =======================================================
// KONTEN HALAMAN 3: JAWABAN TUGAS 3 (Kartu Mahasiswa)
// =======================================================
class HalamanTugas3 extends StatelessWidget {
  const HalamanTugas3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3E5F5), // Latar belakang warna ungu pastel
      child: const Center( // Memposisikan kartu tepat di tengah layar
        child: KartuMahasiswa(
          nama: "Nama Lengka", // SILAKAN GANTI DENGAN NAMA ANDA
          nim: "2021001001",         // SILAKAN GANTI DENGAN NIM ANDA
          programStudi: "Teknik Informatika",
        ),
      ),
    );
  }
}

// Desain Kartu Mahasiswa (Sekarang disatukan di main.dart)
class KartuMahasiswa extends StatelessWidget {
  final String nama;
  final String nim;
  final String programStudi;

  const KartuMahasiswa({
    super.key,
    required this.nama,
    required this.nim,
    required this.programStudi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar tinggi column menyesuaikan isinya
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nama,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 24.0, thickness: 1.0),
          Text(
            "NIM: $nim",
            style: const TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Prodi: $programStudi",
            style: const TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// =======================================================
// KONTEN HALAMAN 1: KODE BAWAAN ANDA
// =======================================================
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Selamat Datang",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.green,
            ),
          ),
          Container(
            width: 200,
            height: 30,
            color: Colors.blue[200],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            width: 400,
            height: 20,
            color: Colors.blue[200],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.redAccent,
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =======================================================
// KONTEN HALAMAN 2: JAWABAN TUGAS 1
// =======================================================
class FormRegistrasi extends StatelessWidget {
  const FormRegistrasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Form Pendaftaran Akun",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(hintText: "Username")),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(hintText: "Email")),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                child: const Text("?"),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}