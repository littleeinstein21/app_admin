// verifikasi_user_screen.dart
import 'package:flutter/material.dart';

class VerifikasiUserScreen extends StatelessWidget {
  const VerifikasiUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👉 nanti ini bisa diambil dari Firestore
    final users = [
      {
        "nama": "Budi Santoso",
        "email": "budi@example.com",
        "telp": "08123456789",
        "gdrive": "https://drive.google.com/file/abc123",
      },
      {
        "nama": "Ani Lestari",
        "email": "ani@example.com",
        "telp": "08987654321",
        "gdrive": "https://drive.google.com/file/xyz456",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi User")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              title: Text(user["nama"]!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${user["email"]}"),
                  Text("Telp/WA: ${user["telp"]}"),
                  Text("Link GDrive: ${user["gdrive"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
