import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:music_app/providers/artist.dart';
import 'package:music_app/providers/song.dart';
import 'package:http/http.dart' as http;

const URL = 'https://conkhunglongnene.site';

class Search with ChangeNotifier {
  List<Song> _songItems = [];
  List<Artist> _artistItems = [];

  List<Song> get songItems => _songItems;
  List<Artist> get artistItems => _artistItems;

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
        log('error search word=$word');
        return;
      }

      List<Song> loadedSongs = [];

      responseData['data']['rows'].forEach((song) {
        loadedSongs.add(Song(song['id'], URL + song['image'], song['name']));
      });
      _songItems = loadedSongs;
      final url2 = Uri.parse(
          'https://conkhunglongnene.site/artist?page=1&size=50&name=$word');
      final response2 = await http.get(url2);
      final responseData2 = json.decode(response2.body);
      if (responseData2['status'] > 200) {
        log('error search word=$word');
        return;
      }

      List<Artist> loadedArtist = [];

      responseData2['data']['rows'].forEach((a) {
        loadedArtist.add(Artist(a['id'], URL + a['image'], a['name']));
      });
      _artistItems = loadedArtist;
      notifyListeners();
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> emptySearch() async {
    _songItems = [];
    _artistItems = [];
    notifyListeners();
  }
}
