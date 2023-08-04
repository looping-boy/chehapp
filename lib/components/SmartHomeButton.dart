import 'dart:math';

import 'package:chehapp/pages/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/SendChat.dart';

class SmartHomeButton extends StatelessWidget {
  final String smartButtonName;
  final String iconPath;
  final bool powerOn;
  void Function(bool)? onChanged;

  final shadow = [
    const BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0x77ffffff)),
    const BoxShadow(
        blurRadius: 20.0,
        offset: Offset(10.0, 10.0),
        color: Color(0x33000000))
  ];

  SmartHomeButton({super.key,
    required this.smartButtonName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SendChat(
                        smartButtonName: smartButtonName,
                        iconPath: iconPath,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: shadow,
              border: Border.all(color: (Colors.grey[800])!, width: 4),
              color: powerOn ? Colors.grey[200] : Colors.grey[900],
              borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(iconPath,
                  height: 45, color: powerOn ? Colors.black : Colors.white),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          smartButtonName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: powerOn ? Colors.black : Colors.white),
                        ),
                      )),
                  Transform.rotate(
                      angle: pi / 2,
                      child:
                      CupertinoSwitch(value: powerOn, onChanged: onChanged))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
