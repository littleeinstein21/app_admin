import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Import halaman lain
import 'borrow_screen.dart';
import 'return_screen.dart';
import 'user_verif_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _currentDate = '';
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    // Inisialisasi locale Indonesia untuk format tanggal
    initializeDateFormatting('id_ID', null).then((_) {
      _updateDateTime();
      Timer.periodic(const Duration(seconds: 1), (timer) => _updateDateTime());
    });
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _currentDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);
      _currentTime = DateFormat('HH:mm:ss').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "Verifikasi User",
        "icon": Icons.verified_user,
        "color": Colors.teal,
        "screen": const VerifikasiUserScreen(),
      },
      {
        "title": "Loker Peminjaman",
        "icon": Icons.book_outlined,
        "color": Colors.indigo,
        "screen": const LokerPeminjamanScreen(),
      },
      {
        "title": "Loker Pengembalian",
        "icon": Icons.assignment_return,
        "color": Colors.deepOrange,
        "screen": const LokerPengembalianScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          'Dashboard Admin',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header tanggal & waktu
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF706FD3), Color(0xFF474787)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentDate,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _currentTime,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Grid menu
            Expanded(
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // ubah ke 2 kalau mau dua kolom
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildDashboardCard(
                    context,
                    title: item["title"],
                    icon: item["icon"],
                    color: item["color"],
                    screen: item["screen"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.9),
              color.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 20),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
