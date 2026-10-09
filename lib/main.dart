import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'theme/app_theme.dart';
import 'widgets/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Demo'),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Muhammad Zhabbala Mendieta Priyadi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Tekan tombol di bawah untuk melihat informasi Mahasiswa.',
              selectionColor: AppColors.background
            ),

            const SizedBox(height: 24),

            AppButton(
              label: 'Buka Link Github Mahasiswa',
              icon: Icons.location_on,
              url: 'https://github.com/zhabbalamendietapriyadi/Muhammad-Zhabbala-Mendieta-Priyadi_Kelompok-3_kh001',
            ),

            const SizedBox(height: 16),

            AppButton(
              label: 'Tes Tombol',
              icon: Icons.touch_app,
              onPressed: () {
                debugPrint('Tombol berhasil ditekan!');
              },
            ),
          ],
        ),
      ),
    );
  }
}