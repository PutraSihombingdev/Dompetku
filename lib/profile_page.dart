import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Color gradientStart = const Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = const Color(0xFFE91E63);   // Pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto profil
            CircleAvatar(
              radius: 50,
              backgroundColor: gradientStart.withOpacity(0.3),
              backgroundImage: AssetImage('assets/profile.png'), // Ganti dengan gambar profil pengguna
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('Putra Sihombing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('putra@example.com', style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 4),
            Text('+62 812-3456-7890', style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 30),

            // Tombol edit profil
            ElevatedButton.icon(
              onPressed: () {
                _showEditProfileDialog(context);
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Edit Profil', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: gradientStart,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: 'Putra Sihombing');
    final TextEditingController emailController = TextEditingController(text: 'putra@example.com');
    final TextEditingController phoneController = TextEditingController(text: '+62 812-3456-7890');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profil'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Nomor HP'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: gradientStart)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Informasi berhasil diperbarui')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: gradientEnd),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
