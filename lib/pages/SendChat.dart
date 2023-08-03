import 'dart:async';

import 'package:flutter/material.dart';

import 'HomePage.dart';

class SendChat extends StatelessWidget {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  final String smartButtonName;
  final String iconPath;
  const SendChat({super.key, required String this.smartButtonName, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "lib/icons/fourdots.png",
                    height: 45,
                    color: Colors.grey[800],
                  ),
                  Hero(
                      tag: smartButtonName,
                      child: Image.asset(
                          iconPath,
                          height: 45,
                          width: 45,
                        color: Colors.grey[800],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),





          ],
        ),
      ),
    );

  }

}


