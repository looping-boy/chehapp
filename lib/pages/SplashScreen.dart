import 'dart:async';

import 'package:flutter/material.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initScreen(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/chehapp.png"), fit: BoxFit.cover),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/logo.png"),
                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  const Text(
                    'ChehApp',
                    style: TextStyle(fontSize: 50.0, color: Colors.white),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  const SizedBox(
                    height: 20,
                  )
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}


