import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runRestaurantApp();
}

void runRestaurantApp() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff92A3FD)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
