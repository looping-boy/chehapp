import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
      ignoring: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20),
          child: Container(
                  transform: Matrix4.translationValues(
                     0, - (300 - widget.offset * 300) , 0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _getFromGallery,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // boxShadow: shadow,
                                border: Border.all(color: (Colors.grey[800])!, width: 4),
                                color: Colors.grey[200],
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
                                        color: (Colors.grey[900])!,
                                        width: 4.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: image != null ? Image.file(image!, width: 160, height: 160, fit: BoxFit.cover,) : Image.asset(
                                          "lib/icons/profile2.JPG",
                                          height: 30,
                                          color: Colors.grey[900],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          "Change your picture",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // boxShadow: shadow,
                                border: Border.all(color: (Colors.grey[800])!, width: 4),
                                color: Colors.grey[200],
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
                                        backgroundImage: AssetImage("lib/icons/micro.png"),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          "Tap to record a 1 second onomatopoeia !",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),




                    ],
                  )
                )
        ),
      ),
    );
  }

  File? image;

  /// Get from gallery
  Future<void> _getFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final imageTemporary = File(pickedFile.path);
      setState(() => image = imageTemporary);
    } on PlatformException catch (e) {
      print("failed to import");
    }
  }

}
