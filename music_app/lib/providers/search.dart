import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:music_app/providers/song.dart';
import 'package:http/http.dart' as http;

const URL = 'https://conkhunglongnene.site';

class Search with ChangeNotifier {
  List<Song> _songItems = [];
  List<Song> _artistItems = [];

  List<Song> get songItems => _songItems;

  Future<void> search(String word) async {
    if (word.isEmpty) {
      return;
    }
    try {
      final url = Uri.parse(
          'https://conkhunglongnene.site/song?size=20&page=1&name=$word');
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        print('error search word=$word');
        return;
      }

      List<Song> loadedSongs = [];

      responseData['data']['rows'].forEach((song) {
        loadedSongs.add(Song(song['id'], URL + song['image'], song['name']));
      });
      _songItems = loadedSongs;
      notifyListeners();
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> emptySearch() async {
    print('cleared');
    _songItems = [];
    _artistItems = [];
    notifyListeners();
  }
}
