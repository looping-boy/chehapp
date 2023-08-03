import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartHomeButton extends StatelessWidget {
  final String smartButtonName;
  final String iconPath;
  final bool powerOn;
  void Function(bool)? onChanged;

  SmartHomeButton(
      {super.key,
      required this.smartButtonName,
      required this.iconPath,
      required this.powerOn,
      required this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Details(trip: trip)));
        },
        decoration: BoxDecoration(
            color: powerOn ? Colors.grey[200] : Colors.grey[900], borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: smartButtonName,
              child: Image.asset(
                iconPath,
                height: 65,
                   color: powerOn ? Colors.black : Colors.white
              ),
            ),
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
                      color: powerOn ? Colors.black : Colors.white
                    ),
                  ),
                )),
                Transform.rotate(
                  angle: pi / 2,
                    child: CupertinoSwitch(
                        value: powerOn,
                        onChanged: onChanged
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
