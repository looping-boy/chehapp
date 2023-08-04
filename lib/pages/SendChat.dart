import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'HomePage.dart';

class SendChat extends StatefulWidget {
  const SendChat({super.key});

  @override
  State<SendChat> createState() => _SendChatState();
}

class _SendChatState extends State<SendChat> {

  bool isSwipingLeftToRight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Gesture Detection'),
      ),
      body: GestureDetector(
        onHorizontalDragStart: (details) {
          // Reset the flag when the user starts the swipe gesture
          isSwipingLeftToRight = false;
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          // Calculate the horizontal drag distance
          double dragDistance = details.primaryDelta ?? 0;

          // If the user is swiping from left to right (positive drag distance)
          // set the flag to true
          if (dragDistance > 20) {
            setState(() {
              isSwipingLeftToRight = true;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          // Handle any logic after the swipe gesture ends (optional)
        },
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: isSwipingLeftToRight ? Colors.green : Colors.blue,
            child: Center(
              child: Text(
                isSwipingLeftToRight ? 'Swiped Left to Right' : 'Swipe to Change Color',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


