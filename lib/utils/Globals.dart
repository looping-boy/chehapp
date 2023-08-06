import 'package:flutter/foundation.dart';

class Globals with ChangeNotifier, DiagnosticableTreeMixin {
  String _pageName = "Cheh App";

  String get pageName => _pageName;

  void setPageName(String newName) {
    _pageName = newName;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('pageName', pageName));
  }
}