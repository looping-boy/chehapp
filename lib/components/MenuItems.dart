import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/Globals.dart';
import 'DisplayPictureScreen.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setImage());
  }

  Future<void> setImage() async {
      setState(() {_image = context.read<Globals>().avatarFile;});
  }

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

  File? _image;
  final imageHelper = ImageHelper();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20),
            child: Container(
                transform: Matrix4.translationValues(
                    0, -(300 - widget.offset * 300), 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final files = await imageHelper.pickImage();
                        if (files.isNotEmpty) {
                          final croppedFile = await imageHelper.crop(
                              file: files.first!, cropStyle: CropStyle.circle);
                          if (croppedFile != null) {
                            setState(() => _image = File(croppedFile.path));
                            context.read<Globals>().setAvatarFile(_image);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              // boxShadow: shadow,
                              border: Border.all(
                                  color: (Colors.grey[800])!, width: 4),
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6.0),
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
                                    // backgroundColor: Colors.grey[200],
                                    foregroundImage: context.read<Globals>().avatarFile != null
                                        ? FileImage(context.read<Globals>().avatarFile!)
                                        : null,
                                    // child: Padding(
                                    //   padding: const EdgeInsets.only(top: 5.0),
                                    //   child: DisplayPictureScreen(imageAnalysed: "base64String"),
                                    // ),
                                  ),
                                ),
                                const Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    "Change your picture for the game",
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              // boxShadow: shadow,
                              border: Border.all(
                                  color: (Colors.grey[800])!, width: 4),
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6.0),
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
                                      backgroundImage:
                                          AssetImage("lib/icons/micro.png"),
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
                ))),
      ),
    );
  }
}

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<List<XFile?>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 10,
    bool multiple = false,
  }) async {
    if (multiple) {
      return await _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }

    final file = await _imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );

    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> crop(
      {required XFile file, CropStyle cropStyle = CropStyle.circle}) async {
    return await ImageCropper().cropImage(
      cropStyle: cropStyle,
      sourcePath: file.path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   // CropAspectRatioPreset.ratio3x2,
      //   // CropAspectRatioPreset.original,
      //   // CropAspectRatioPreset.ratio4x3,
      //   // CropAspectRatioPreset.ratio16x9
      // ],
      compressQuality: 10,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        //   WebUiSettings(
        //     context: context,
        //   ),
      ],
    );
  }
}
