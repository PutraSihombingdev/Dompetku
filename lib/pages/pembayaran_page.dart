import 'package:flutter/material.dart';

class PembayaranPage extends StatelessWidget {
  final List<Map<String, dynamic>> paymentOptions = [
    {
      'icon': Icons.bolt,
      'title': 'Tagihan Listrik',
      'description': 'Bayar tagihan listrik PLN bulanan',
      'color': Colors.orange
    },
    {
      'icon': Icons.water_drop,
      'title': 'Tagihan Air',
      'description': 'Bayar tagihan air rumah tangga',
      'color': Colors.blue
    },
    {
      'icon': Icons.wifi,
      'title': 'Internet',
      'description': 'Bayar langganan Wi-Fi & TV Kabel',
      'color': Colors.deepPurple
    },
    {
      'icon': Icons.phone_android,
      'title': 'Pulsa & Paket Data',
      'description': 'Isi ulang pulsa dan beli paket data',
      'color': Colors.green
    },
    {
      'icon': Icons.shopping_bag,
      'title': 'Merchant',
      'description': 'Bayar di merchant offline & online',
      'color': Colors.red
    },
    {
      'icon': Icons.autorenew,
      'title': 'Auto Debit',
      'description': 'Aktifkan pembayaran otomatis bulanan',
      'color': Colors.teal
    },
  ];

  final Color gradientStart = Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = Color(0xFFE91E63);   // Pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Pembayaran', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pembayaran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: gradientStart,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pilih layanan yang ingin Anda bayar',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: paymentOptions.length,
                itemBuilder: (context, index) {
                  final item = paymentOptions[index];
                  return _buildPaymentCard(item, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> item, BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showConfirmationDialog(context, item['title']),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item['color'].withOpacity(0.12),
                ),
                child: Icon(item['icon'], size: 28, color: item['color']),
              ),
              const SizedBox(height: 12),
              Text(
                item['title'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                item['description'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: gradientStart.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.help_outline, size: 36, color: gradientStart),
              ),
              const SizedBox(height: 16),
              Text(
                'Konfirmasi Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: gradientStart,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lanjutkan pembayaran untuk $title?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: gradientStart),
                      ),
                      child: Text('Batal', style: TextStyle(color: gradientStart)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSuccessPayment(context, title);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gradientEnd,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Bayar', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessPayment(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pembayaran $title berhasil!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: gradientStart,
        action: SnackBarAction(
          label: 'Lihat',
          textColor: Colors.white,
          onPressed: () {
            _showReceiptDialog(context, title);
          },
        ),
      ),
    );
  }

  void _showReceiptDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 40, color: Colors.green),
              ),
              const SizedBox(height: 16),
              Text(
                'Pembayaran Berhasil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Anda telah berhasil melakukan pembayaran untuk $title',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildReceiptDetail('ID Transaksi', '#TRX-20230701-001'),
                    _buildReceiptDetail('Tanggal', '01 Juli 2023, 15:30'),
                    _buildReceiptDetail('Jumlah', 'Rp 450.000'),
                    _buildReceiptDetail('Metode', 'Dompet Digital'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gradientEnd,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Tutup', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
