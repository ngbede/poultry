import 'package:flutter/foundation.dart';

/// Layout screen index provider to manage screen change state via bottom navigation bar

class LayoutIndexProv with ChangeNotifier {
  int _selectedScreen = 0;

  void onTapChangeScreen(int index) {
    _selectedScreen = index;
    notifyListeners();
  }

  int get currentScreen => _selectedScreen;
}
