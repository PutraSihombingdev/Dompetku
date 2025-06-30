import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String selectedTarget = 'DompetKu';

  final Color gradientStart = Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = Color(0xFFE91E63);   // Pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Transfer Dana', style: TextStyle(color: Colors.white)),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Deskripsi
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: gradientStart.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                ),
                const SizedBox(width: 12),

              ],
            ),
            const SizedBox(height: 20),

            // Card Form Input
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Dropdown tujuan transfer
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Transfer ke:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedTarget,
                      items: ['DompetKu', 'Bank Eksternal']
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTarget = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Rekening/ID
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedTarget == 'DompetKu'
                            ? 'ID Pengguna DompetKu'
                            : 'Nomor Rekening Bank',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _accountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: selectedTarget == 'DompetKu'
                            ? 'Masukkan ID pengguna'
                            : 'Masukkan nomor rekening bank',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nominal
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nominal Transfer',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: 'Rp ',
                        hintText: 'Masukkan jumlah',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        label: Text('Lanjutkan', style: TextStyle(color:Colors.white),),
                        onPressed: _handleTransfer,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: gradientEnd,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTransfer() {
    final target = _accountController.text.trim();
    final nominal = _amountController.text.trim();

    if (target.isEmpty || nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon lengkapi semua field.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      _showConfirmationDialog(context, selectedTarget, target, nominal);
    }
  }

  void _showConfirmationDialog(
      BuildContext context, String tujuan, String rekening, String nominal) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Konfirmasi Transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tujuan: $tujuan'),
            Text('Rekening: $rekening'),
            Text('Nominal: Rp $nominal'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: gradientEnd)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: gradientEnd,
            ),
            child: Text('Kirim', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
            const SizedBox(height: 12),
            Text('Transfer Berhasil!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Dana berhasil dikirim.', style: TextStyle(color: Colors.grey[700])),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup', style: TextStyle(color: gradientStart)),
          ),
        ],
      ),
    );
  }
}
