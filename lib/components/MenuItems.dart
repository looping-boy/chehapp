import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/UserContainer.dart';

class MenuItems extends StatefulWidget {
  double offset;
  MenuItems({super.key, required this.offset});

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool isSwipingLeftToRight = false;

  bool startAnimation = false;
  double screenWidth = 0;

  final shadowLight = const TextStyle(shadows: [
    BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0x55ffffff)),
    BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0x44000000))
  ]);

  void userClicked(bool value, int index) {
    setState(() {
      profil[index][2] = value;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          profil[index][2] = false;
        });
      });
    });
  }

  List profil = [
    ["Guillaume", "lib/icons/guillaume.png", true],
    ["Thara", "lib/icons/thara.jpeg", true],
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profil.length,
              itemBuilder: (context, index) {
                return Container(
                  transform: Matrix4.translationValues(
                     0, - (300 - widget.offset * 300) , 0),
                  child: UserContainer(
                    name: profil[index][0],
                    iconPath: profil[index][1],
                    colorTriggered: profil[index][2],
                    onClicked: (value) => userClicked(value, index),
                  ),
                );
              },
              // separatorBuilder: (context, index) => const Divider(),// here u can customize the space.

          ),
        ),
      ),
    );
  }
}
