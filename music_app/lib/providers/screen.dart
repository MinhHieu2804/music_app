import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Screen with ChangeNotifier {
  int _currentScreen = 0;
  String _artistName = "";
  int _artistId = -1;

  int get currentScreen => _currentScreen;
  String get artistName => _artistName;
  int get artistId => _artistId;

  void setCurrentScreen(int set, String artistName, int artist) {
    _currentScreen = set;
    _artistName = artistName;
    _artistId = artist;
    notifyListeners();
  }
}
