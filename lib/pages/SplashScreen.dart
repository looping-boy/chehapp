import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/Routing.dart';
import 'HomePage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final shadowStrong = const TextStyle(shadows: [
    BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0x66000000)),
    BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0x66000000))
  ]);

  initScreen(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.grey[400],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Stack(children: [
                      Opacity(opacity: 0.8, child: Image.asset("lib/icons/cheh.png", color: Colors.black)),
                      ClipRect(clipBehavior: Clip.none, child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Image.asset(
                            "lib/icons/cheh.png",
                          )))
                    ]),
                  )
                  ,
                  Text("CHEH APP",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 72, textStyle: shadowStrong)),
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    final Routing routing = Routing();

    Widget route = const HomePage();

    Navigator.of(context).push(routing.createRoute(route));
  }
}
