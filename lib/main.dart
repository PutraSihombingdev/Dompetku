import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() => runApp(DompetKuApp());

class DompetKuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DompetKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Poppins',
      ),
      home: LoginScreen(), // mulai dari login
    );
  }
}
