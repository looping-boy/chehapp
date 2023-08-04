import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  final double opacity = 1;

  void animOpacity() {
    // setState(() {
    //   opacity = 1;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
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
                Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.grey[900],
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),



        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(125.0);
}
