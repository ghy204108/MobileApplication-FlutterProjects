import 'package:flutter/material.dart';
import 'screens/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Food Intro App',
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}