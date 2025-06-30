import 'package:flutter/material.dart';
import 'pages/pembayaran_page.dart';
import 'pages/transfer_page.dart';
import 'pages/mutasi_page.dart';
import 'pages/qrcode_page.dart';
import 'pages/split_paymment.dart';
import 'pages/pengaturan_page.dart';
import 'login_screen.dart';
import 'pages/profil_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final Color gradientStart = Color(0xFF9C27B0); // Ungu
  final Color gradientEnd = Color(0xFFE91E63);   // Pink

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Tokopedia',
      'amount': '-\$80.00',
      'icon': Icons.shopping_cart,
      'color': Colors.green,
      'date': 'Feb 27 • 8:30 AM'
    },
    {
      'title': 'Netflix',
      'amount': '-\$42.00',
      'icon': Icons.ondemand_video,
      'color': Colors.red,
      'date': 'Feb 27 • 5:56 AM'
    },
    {
      'title': 'Spotify Premium',
      'amount': '-\$15.00',
      'icon': Icons.music_note,
      'color': Colors.greenAccent,
      'date': 'Feb 26 • 11:24 AM'
    },
  ];

  final List<Map<String, dynamic>> actions = [];

  @override
  void initState() {
    super.initState();
    actions.addAll([
      {'label': 'Payment', 'icon': Icons.payment, 'page': PembayaranPage()},
      {'label': 'Transfer', 'icon': Icons.sync_alt, 'page': TransferPage()},
      {'label': 'Split', 'icon': Icons.splitscreen, 'page': SplitPaymentPage()},
    ]);
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => QRCodePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MutasiPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PengaturanPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: gradientStart,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Putra Sihombing",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.notifications, color: gradientStart),
                ],
              ),
              SizedBox(height: 20),

              // Balance Card
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradientStart, gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Balance", style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 10),
                      Text(
                        "\$152,021,230",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("1320 **** **** 6473", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Action Buttons
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final action = actions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => action['page']),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gradientStart.withOpacity(0.15),
                                gradientEnd.withOpacity(0.15)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(action['icon'], color: gradientStart),
                        ),
                        SizedBox(height: 8),
                        Text(action['label'], style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 25),

              // Transaction Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Transactions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("See all", style: TextStyle(color: gradientStart, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(height: 15),

              // Transaction List
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: tx['color'].withOpacity(0.2),
                        child: Icon(tx['icon'], color: tx['color']),
                      ),
                      title: Text(tx['title'], style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(tx['date'], style: TextStyle(fontSize: 12)),
                      trailing: Text(
                        tx['amount'],
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: gradientStart,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Qr Code'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Mutasi'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }
}
