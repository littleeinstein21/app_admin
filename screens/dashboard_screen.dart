// dashboard_screen.dart
import 'package:flutter/material.dart';

import 'borrow_screen.dart';
import 'return_screen.dart';
import 'user_verif_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Admin"),
        backgroundColor: const Color(0xFF2C2C54),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuButton(
              context,
              "Verifikasi User",
              const VerifikasiUserScreen(),
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Loker Peminjaman",
              const LokerPeminjamanScreen(),
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Loker Pengembalian",
              const LokerPengembalianScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: const Color(0xFF706FD3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
