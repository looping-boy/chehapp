import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/Globals.dart';


class CustomAppBar2 extends StatefulWidget implements PreferredSizeWidget {
  Offset offset;
  double opacity;
  void Function() onChehClicked;

  CustomAppBar2({super.key, required this.offset, required this.opacity, required this.onChehClicked});

  @override
  State<CustomAppBar2> createState() => _CustomAppBar2State();

  @override
  Size get preferredSize => const Size.fromHeight(125.0);
}

class _CustomAppBar2State extends State<CustomAppBar2> {
  final double horizontalPadding = 35;
  final double verticalPadding = 25;

  double opacity = 0;

  void animOpacity() {
    setState(() {
      opacity = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => animOpacity());
  }

  final shadowLight = const TextStyle(shadows: [
    BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0x55ffffff)),
    BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0x44000000))
  ]);

  final shadowStrong = const TextStyle(shadows: [
    BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0xffffffff)),
    BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0xff000000))
  ]);

  @override
  Widget build(BuildContext context) {

    final globals = Provider.of<Globals>(context);

    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration.zero,
          curve: Curves.easeOut,
          height: widget.offset.dy,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black.withOpacity(widget.opacity),
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside),
              color: Colors.white.withOpacity(widget.opacity),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: (Colors.grey[400])!.withOpacity(0),
                    spreadRadius: 0,
                    blurRadius: 0)
              ]),
          child: SafeArea(
            bottom: true,
            child: SizedBox(
              height: 92,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                          child: Text(
                            "Welcome to the",
                            style: shadowStrong
                                .merge(TextStyle(fontSize: 20, color: Colors.grey[700])),
                          ),
                        ),
                        Text(
                          context.watch<Globals>().pageName,
                          style:
                          GoogleFonts.bebasNeue(fontSize: 72, textStyle: shadowLight),
                        ),
                      ],
                    ),
                    Container(
                      height: 75.0,
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: (Colors.grey[900])!,
                            width: 4.0,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: widget.onChehClicked,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: (Colors.grey[300])!.withOpacity(opacity),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                curve: Curves.decelerate,
                                opacity: opacity,
                                child: Image.asset(
                                  "lib/icons/cheh.png",
                                  height: 45,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: widget.onChehClicked,
                    //   child: Icon(
                    //     Icons.person,
                    //     size: 45,
                    //     color: Colors.grey[900],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ),

      ]
    );
  }
}
