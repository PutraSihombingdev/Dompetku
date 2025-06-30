import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Color gradientStart = const Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = const Color(0xFFE91E63);   // Pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Foto & Nama
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [gradientStart, gradientEnd],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/amjay.png'), // optional image
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Putra Sihombing',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('putra@gmail.com', style: TextStyle(color: Colors.grey[700])),
                Text('+62 812-3456-7890', style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Informasi Akun
          _buildProfileCard(Icons.lock, 'Keamanan & PIN', 'Ubah PIN atau aktifkan verifikasi dua langkah'),
          _buildProfileCard(Icons.toggle_on, 'Fitur Aktif', 'Aktifkan atau nonaktifkan fitur tertentu'),
          _buildProfileCard(Icons.description, 'Syarat & Ketentuan', 'Lihat kebijakan penggunaan aplikasi'),
          _buildProfileCard(Icons.logout, 'Keluar Akun', 'Logout dengan aman dari aplikasi', isLogout: true),

          const SizedBox(height: 30),

          // Tombol Edit Profil
          ElevatedButton.icon(
            onPressed: () => _showEditProfileDialog(context),
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text('Edit Profil', style: TextStyle(fontSize: 16, color: Colors.white) ),
            style: ElevatedButton.styleFrom(
              backgroundColor: gradientStart,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              shadowColor: gradientEnd.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(IconData icon, String title, String subtitle, {bool isLogout = false}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isLogout ? Colors.red[50] : gradientStart.withOpacity(0.1),
          child: Icon(icon, color: isLogout ? Colors.red : gradientStart),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Tambahkan aksi sesuai fitur
        },
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Nomor HP')),
          ],
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
                const SnackBar(content: Text('Profil berhasil diperbarui')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: gradientEnd),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
