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
    return Container(alignment: Alignment.center, child: Text("SEND CHAT"));
  }
}
