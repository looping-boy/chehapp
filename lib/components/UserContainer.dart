import 'package:flutter/material.dart';

class UserContainer extends StatefulWidget {
  String name;
  String iconPath;
  bool colorTriggered;
  void Function(bool)? onClicked;

  UserContainer(
      {super.key,
      required this.name,
      required this.iconPath,
      required this.colorTriggered,
      required this.onClicked});

  @override
  State<UserContainer> createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  final shadow = [
    const BoxShadow(
        blurRadius: 20.0,
        offset: Offset(-10.0, -10.0),
        color: Color(0x77ffffff)),
    const BoxShadow(
        blurRadius: 20.0, offset: Offset(10.0, 10.0), color: Color(0x33000000))
  ];

  setColor() {
    setState(() {
      widget.colorTriggered = !widget.colorTriggered;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          widget.colorTriggered = !widget.colorTriggered;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {setColor()},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: shadow,
              border: Border.all(color: (Colors.grey[800])!, width: 4),
              color:
                  widget.colorTriggered ? Colors.grey[200] : Colors.grey[900],
              borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[900]!,
                      width: 4.0,
                    ),
                  ),
                  child: ClipOval(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: AssetImage(
                        widget.iconPath,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:
                            widget.colorTriggered ? Colors.black : Colors.white),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
