import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class OpenGallery extends StatefulWidget {
  const OpenGallery({Key? key}) : super(key: key);

  @override
  State<OpenGallery> createState() => _OpenGalleryState();
}

class _OpenGalleryState extends State<OpenGallery> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getFromGallery,
      child: Container(
        height: 200,
        color: Colors.red,
        child: image != null ? Image.file(image!, width: 160, height: 160, fit: BoxFit.cover,) : const Text("hello")
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

