import 'package:flutter/material.dart';

class SaldoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lihat Saldo')),
      body: Center(
        child: Text('Saldo kamu: Rp1.000.000', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
