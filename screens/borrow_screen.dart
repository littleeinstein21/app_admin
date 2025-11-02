import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LokerPeminjamanScreen extends StatelessWidget {
  const LokerPeminjamanScreen({super.key});

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return "-";
    if (timestamp is Timestamp) {
      return DateFormat('dd MMM yyyy • HH:mm').format(timestamp.toDate());
    }
    return timestamp.toString();
  }

  @override
  Widget build(BuildContext context) {
    final borrowsRef = FirebaseFirestore.instance
        .collection('borrows')
        .where('actionType', isEqualTo: 'BORROW_REQUEST');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Daftar Peminjaman Buku",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF035C44),
        centerTitle: true,
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: borrowsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF035C44)),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada data peminjaman.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final title = data['bookTitle'] ?? 'Tanpa Judul';
              final borrower = data['userName'] ?? 'Tidak diketahui';
              final location = data['pickupLocation'] ?? '-';
              final isbn = data['isbn'] ?? '-'; // ✅ field diperbaiki di sini
              final date = _formatTimestamp(
                data['borrowDate'] ??
                    data['otpGeneratedAt'] ??
                    data['createdAt'],
              );

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF035C44),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.book, color: Colors.white, size: 26),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.person, "Peminjam", borrower),
                        _buildInfoRow(Icons.location_on, "Lokasi", location),
                        _buildInfoRow(Icons.qr_code, "Kode ISBN", isbn),
                        _buildInfoRow(Icons.calendar_today, "Tanggal", date),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF035C44), size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
