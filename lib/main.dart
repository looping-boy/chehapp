
import 'package:chehapp/pages/SplashScreen.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const ChehApp());
}

class ChehApp extends StatelessWidget {
  const ChehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

