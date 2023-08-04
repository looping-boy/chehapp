import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/CupertinoRoute.dart';
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

  late Widget hello;

  initScreen(BuildContext context) {
    hello = Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.grey[400],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(children: [
                      Opacity(opacity: 0.8, child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Image.asset("lib/icons/cheh.png", color: Colors.black),
                      )),
                      ClipRect(clipBehavior: Clip.hardEdge, child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              "lib/icons/cheh.png",
                            ),
                          )))
                    ]),


                  Text("CHEH APP",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 72, textStyle: shadowStrong)),
                ]
            )
        )
    );

    return hello;
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
    // final Routing routing = Routing();

    Widget route = const HomePage();


    Navigator.of(context).push(createRoute(route));
  }

  Route createRoute(Widget route) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            // Animation is completed, remove the hello page from the widget tree
            setState(() {
              hello = const SizedBox.shrink();
            });
          }
        });
        return Stack(
          children: [
            SlideTransition(
              position: Tween(begin: Offset(1, 0), end: Offset.zero).animate(animation),
              child: child,
            ),
            SlideTransition(
              position: Tween(begin: Offset.zero, end: Offset(-1, 0)).animate(animation),
              child: hello,
            ),
          ],
        );
      },
    );
  }
}
