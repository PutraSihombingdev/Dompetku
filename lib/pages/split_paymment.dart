import 'package:flutter/material.dart';

class SplitPaymentPage extends StatefulWidget {
  @override
  _SplitPaymentPageState createState() => _SplitPaymentPageState();
}

class _SplitPaymentPageState extends State<SplitPaymentPage> {
  final List<String> paymentMethods = [
    'Saldo Dompet',
    'Kartu Kredit',
    'Transfer Bank',
    'QRIS',
    'Gopay',
    'OVO',
  ];

  final Set<String> selectedMethods = {};

  final Color gradientStart = Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = Color(0xFFE91E63);   // Pink

  void _toggleSelection(String method) {
    setState(() {
      if (selectedMethods.contains(method)) {
        selectedMethods.remove(method);
      } else {
        selectedMethods.add(method);
      }
    });
  }

  void _proceedPayment() {
    if (selectedMethods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pilih minimal satu metode pembayaran.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                const SizedBox(height: 16),
                Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Transaksi menggunakan metode:\n' + selectedMethods.join(', '),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gradientStart,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  ),
                  child: const Text('Tutup', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Split Payment',style: TextStyle(color: Colors.white),),
        centerTitle: true,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: paymentMethods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  final isSelected = selectedMethods.contains(method);
                  return GestureDetector(
                    onTap: () => _toggleSelection(method),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? gradientStart.withOpacity(0.15) : Colors.grey[100],
                        border: Border.all(
                          color: isSelected ? gradientStart : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: isSelected ? gradientStart : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              method,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? gradientStart : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _proceedPayment,
                label: const Text('Bayar Sekarang', style: TextStyle(fontSize: 16,color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: gradientEnd,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
