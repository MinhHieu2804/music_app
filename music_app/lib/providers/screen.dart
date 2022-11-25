import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Screen with ChangeNotifier {
  int _currentScreen = 0;
  String _artistName = "";
  int _artistId = -1;
  int _playListId = -1;
  int albumId = -1;
  String albumName = "";

  int get currentScreen => _currentScreen;
  String get artistName => _artistName;
  int get artistId => _artistId;
  int get playListId => _playListId;

  void setCurrentScreen(int set, String artistName, int artist) {
    _currentScreen = set;
    _artistName = artistName;
    _artistId = artist;
    notifyListeners();
  }

  Future<void> setPlayListId(int id) async {
    _playListId = id;
    notifyListeners();
  }

  Future<void> setAlbum(int id, String name) async {
    albumId = id;
    albumName = name;
    notifyListeners();
  }
}
