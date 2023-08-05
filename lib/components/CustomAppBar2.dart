import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar2 extends StatefulWidget implements PreferredSizeWidget {

  CustomAppBar2({Key? key});

  @override
  State<CustomAppBar2> createState() => _CustomAppBar2State();

  @override
  Size get preferredSize => Size.fromHeight(125.0);
}

class _CustomAppBar2State extends State<CustomAppBar2> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  double opacity = 0;

  void animOpacity() {
    setState(() {
      opacity = 1;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => animOpacity());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 75.0,
                height: 75.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (Colors.grey[900])!,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[200],
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
              GestureDetector(
                // onTap: widget.carouselSliderController.nextPage(const Duration(seconds: 1)),
                child: Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
