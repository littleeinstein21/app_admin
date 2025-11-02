import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LokerPengembalianScreen extends StatelessWidget {
  const LokerPengembalianScreen({super.key});

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return "-";
    if (timestamp is Timestamp) {
      return DateFormat('dd MMM yyyy HH:mm').format(timestamp.toDate());
    }
    return timestamp.toString();
  }

  @override
  Widget build(BuildContext context) {
    final borrowsRef = FirebaseFirestore.instance
        .collection('borrows')
        .where('actionType', isEqualTo: 'PICKUP'); // hanya ambil PICKUP

    return Scaffold(
      appBar: AppBar(
        title: const Text("Loker Pengembalian Buku"),
        backgroundColor: const Color(0xFF035C44),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: borrowsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada pengembalian."));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final title = data['bookTitle'] ?? 'Tanpa Judul';
              final borrower = data['userName'] ?? 'Tidak diketahui';
              final location = data['pickupLocation'] ?? '-';
              final date = _formatTimestamp(
                data['borrowDate'] ?? data['createdAt'],
              );

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  leading:
                      const Icon(Icons.assignment_return, color: Colors.green),
                  title: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("👤 Pengembali: $borrower"),
                      Text("📍 Lokasi: $location"),
                      Text("📅 Tanggal: $date"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
