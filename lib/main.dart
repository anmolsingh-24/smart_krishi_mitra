import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(SmartKrishiMitraApp());
}

class SmartKrishiMitraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Krishi Mitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      // Start at the login prototype
      home: LoginPage(),
      // Optionally add named routes for clarity
      routes: {'/home': (_) => HomePage()},
    );
  }
}
