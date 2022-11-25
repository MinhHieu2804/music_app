import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/providers/song.dart';
import 'package:provider/provider.dart';

class PlayingList with ChangeNotifier {
  List<Song>? items;

  List<Song>? originItem;

  void setPlayingList(List<Song> list) {
    items = List<Song>.from(list);
    originItem = List<Song>.from(list);

    notifyListeners();
  }

  void getShuffle() {
    items!.shuffle();
  }

  void unShuffle() {
    items = originItem;
  }

  int getNextSong(int id) {
    int re = items!.indexWhere((element) => element.id == id);
    if (re < items!.length - 1) {
      return items![re + 1].id;
    }
    return items![0].id;
  }

  int getPreSong(int id) {
    int re = items!.indexWhere((element) => element.id == id);
    if (re >= 1) {
      return items![re - 1].id;
    }
    return items![items!.length - 1].id;
  }
}
