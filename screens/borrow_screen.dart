// loker_peminjaman_screen.dart
import 'package:flutter/material.dart';

class LokerPeminjamanScreen extends StatelessWidget {
  const LokerPeminjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👉 nanti ini bisa diambil dari Firestore (filter by tanggal hari ini)
    final peminjamanHariIni = [
      {"judul": "Algoritma Pemrograman", "peminjam": "Budi Santoso"},
      {"judul": "Dasar Jaringan Komputer", "peminjam": "Ani Lestari"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Loker Peminjaman")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: peminjamanHariIni.length,
        itemBuilder: (context, index) {
          final buku = peminjamanHariIni[index];
          return Card(
            child: ListTile(
              title: Text(buku["judul"]!),
              subtitle: Text("Dipinjam oleh: ${buku["peminjam"]}"),
            ),
          );
        },
      ),
    );
  }
}
