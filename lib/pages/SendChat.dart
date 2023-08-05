import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/UserContainer.dart';

class SendChat extends StatefulWidget {
  const SendChat({super.key});

  @override
  State<SendChat> createState() => _SendChatState();
}

class _SendChatState extends State<SendChat> {
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
      users[index][2] = value;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          users[index][2] = false;
        });
      });
    });
  }

  List users = [
    ["Guillaume", "lib/icons/guillaume.png", true],
    ["Arnaud", "lib/icons/arnaud.jpeg", true],
    ["Thara", "lib/icons/thara.jpeg", true],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 210),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Cheh Room",
            style:
                GoogleFonts.bebasNeue(fontSize: 72, textStyle: shadowLight)
                    .merge(TextStyle()),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
            EdgeInsets.fromLTRB(4, 0, 0, 8.0),
            child: AnimatedContainer(
              alignment: Alignment.centerLeft,
              onEnd: () => {},
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              child: Container(
                height: 2.0,
                width: 250.0,
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(
            height: 400,
            child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300 + (index * 150)),
                      transform: Matrix4.translationValues(
                          0, startAnimation ? 0 : screenWidth, 0),
                      child: UserContainer(
                        name: users[index][0],
                        iconPath: users[index][1],
                        colorTriggered: users[index][2],
                        onClicked: (value) => userClicked(value, index),
                      ),
                    );
                  }),
          ),

        ],
      ),
    );
  }
}
