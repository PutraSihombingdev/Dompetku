import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  final Color gradientStart = const Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = const Color(0xFFE91E63);   // Pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('Pengaturan', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Keamanan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.lock, color: gradientEnd),
            title: const Text('Ubah PIN Keamanan'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.fingerprint, color: gradientEnd),
            title: const Text('Autentikasi Biometrik'),
            trailing: Switch(
              value: true,
              onChanged: (val) {},
              activeColor: gradientEnd,
            ),
          ),

          const SizedBox(height: 16),
          const Text('Preferensi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.notifications, color: gradientEnd),
            title: const Text('Kelola Notifikasi'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings_applications, color: gradientEnd),
            title: const Text('Fitur Otomatis'),
            trailing: Switch(
              value: false,
              onChanged: (val) {},
              activeColor: gradientEnd,
            ),
          ),

          const SizedBox(height: 16),
          const Text('Informasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.description, color: gradientEnd),
            title: const Text('Syarat & Ketentuan'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: gradientEnd),
            title: const Text('Kebijakan Privasi'),
            onTap: () {},
          ),

          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar Akun', style: TextStyle(color: Colors.red)),
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: gradientStart)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst); // kembali ke awal
            },
            style: ElevatedButton.styleFrom(backgroundColor: gradientEnd),
            child: const Text('Keluar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
