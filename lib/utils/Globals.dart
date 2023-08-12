import 'dart:html';

import 'package:flutter/foundation.dart';

class Globals with ChangeNotifier, DiagnosticableTreeMixin {
  String _pageName = "Cheh App";
  File? _avatarFile;

  String get pageName => _pageName;
  File? get avatarFile => _avatarFile;

  void setPageName(String newName) {
    _pageName = newName;
    notifyListeners();
  }

  void setAvatarFile(File? avatarFile) {
    _avatarFile = avatarFile;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('pageName', pageName));
  }
}