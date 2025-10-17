// verifikasi_user_screen.dart
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifikasiUserScreen extends StatelessWidget {
  const VerifikasiUserScreen({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = [
      {
        "nama": "Budi Santoso",
        "email": "budi@example.com",
        "telp": "08123456789",
        "gdrive":
            "https://drive.google.com/file/d/1-uyOe57Wac6jA10h4JX_q3FB05iK7RAK/view?usp=sharing",
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
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user["nama"]!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Email: ${user["email"]}"),
                  Text("Telp/WA: ${user["telp"]}"),
                  InkWell(
                    onTap: () => _openUrl(user["gdrive"]!),
                    child: Text(
                      "Link GDrive",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          debugPrint("Don't Verify ${user["nama"]}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("${user["nama"]} marked as NOT verified"),
                            ),
                          );
                        },
                        child: const Text("Don't Verify"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          debugPrint("Verify ${user["nama"]}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${user["nama"]} verified"),
                            ),
                          );
                        },
                        child: const Text("Verify"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
