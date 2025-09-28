// loker_pengembalian_screen.dart
import 'package:flutter/material.dart';

class LokerPengembalianScreen extends StatelessWidget {
  const LokerPengembalianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👉 nanti ini bisa diambil dari Firestore (filter by tanggal hari ini)
    final pengembalianHariIni = [
      {"judul": "Matematika Diskrit", "pengembali": "Siti Aminah"},
      {"judul": "Pemrograman Mobile", "pengembali": "Andi Wijaya"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Loker Pengembalian")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pengembalianHariIni.length,
        itemBuilder: (context, index) {
          final buku = pengembalianHariIni[index];
          return Card(
            child: ListTile(
              title: Text(buku["judul"]!),
              subtitle: Text("Dikembalikan oleh: ${buku["pengembali"]}"),
            ),
          );
        },
      ),
    );
  }
}
