import 'package:flutter/material.dart';

class QRCodePage extends StatelessWidget {
  final Color gradientStart = const Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = const Color(0xFFE91E63);   // Pink

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code DompetKu', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 0,
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
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.qr_code_scanner), text: 'Scan QR'),
              Tab(icon: Icon(Icons.qr_code), text: 'QR Saya'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildScanQR(context),
            _buildMyQR(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScanQR(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'Arahkan kamera ke QR Merchant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Pembayaran otomatis terdeteksi jika QR sesuai standar QRIS.',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Implementasi logika scan QR nanti diintegrasi dengan kamera
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur scan QR belum tersedia.')),
                );
              },
              label: const Text('Pindai Sekarang',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: gradientEnd,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyQR(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Placeholder
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: gradientStart, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.qr_code, size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tunjukkan QR ini untuk menerima pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'ID: 081234567890\nNama: Putra Sihombing',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                // Tambahkan aksi download/share QR
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berbagi QR belum tersedia.')),
                );
              },
              icon: const Icon(Icons.share),
              label: const Text('Bagikan QR'),
              style: OutlinedButton.styleFrom(
                foregroundColor: gradientEnd,
                side: BorderSide(color: gradientEnd),
              ),
            )
          ],
        ),
      ),
    );
  }
}
