import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:typed_data';

class Globals with ChangeNotifier, DiagnosticableTreeMixin {
  String _pageName = "Cheh App";
  File? _avatarFile;

  String get pageName => _pageName;
  File? get avatarFile => _avatarFile;

  Globals() {
    initAvatarFileFromLocalStorage();
  }

  void setPageName(String newName) {
    _pageName = newName;
    notifyListeners();
  }

  void setAvatarFile(File? avatarFile) {
    _avatarFile = avatarFile;
    saveFileToLocalStorage(avatarFile);
    notifyListeners();
  }

  Future<void> saveFileToLocalStorage(File? avatarFile) async {
    Uint8List imageBytes = await avatarFile!.readAsBytes();
    String base64Image = base64.encode(imageBytes);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/avatar');
    await file.writeAsString(base64Image);
  }

  Future<void> initAvatarFileFromLocalStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/avatar');

    if (file.existsSync()) {
      String base64Image = await file.readAsString();
      File fileImg;
      final decodedBytes = base64Decode(base64Image);
      final directory = await getApplicationDocumentsDirectory();
      fileImg = File('${directory.path}/avatar');
      fileImg.writeAsBytesSync(List.from(decodedBytes));
      _avatarFile = fileImg;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('pageName', pageName));
  }
}