
import 'package:chehapp/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() {
  // SET STATUS BAR ICONS COLOR :
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light
  ));
  runApp(const ChehApp());
}

class ChehApp extends StatelessWidget {
  const ChehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }
          )
      ),
    );
  }
}

