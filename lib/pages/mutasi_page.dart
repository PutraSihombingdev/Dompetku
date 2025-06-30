import 'package:flutter/material.dart';

class MutasiPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Tokopedia',
      'amount': '-Rp 150.000',
      'icon': Icons.shopping_bag,
      'color': Colors.green,
      'date': '28 Juni 2025 • 13:20'
    },
    {
      'title': 'Transfer ke BCA',
      'amount': '-Rp 500.000',
      'icon': Icons.account_balance,
      'color': Colors.blue,
      'date': '27 Juni 2025 • 18:45'
    },
    
  ];

  final Color gradientStart = Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = Color(0xFFE91E63);   // Pink

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Filter Transaksi'),
        content: const Text('Fitur filter akan ditambahkan nanti.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Mutasi Transaksi', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
          icon: const Icon(Icons.filter_alt, color: Colors.white),
          tooltip: 'Filter',
          onPressed: () => _showFilterDialog(context),
        ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Transaksi Kamu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  final isIncome = tx['amount'].toString().startsWith('+');
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: tx['color'].withOpacity(0.15),
                        child: Icon(tx['icon'], color: tx['color']),
                      ),
                      title: Text(
                        tx['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        tx['date'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      trailing: Text(
                        tx['amount'],
                        style: TextStyle(
                          color: isIncome ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
