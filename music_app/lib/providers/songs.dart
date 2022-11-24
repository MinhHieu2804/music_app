import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:music_app/providers/song.dart';
import 'package:http/http.dart' as http;

class Songs with ChangeNotifier {
  List<Song> _items = [];
  List<Song> _itemArtist = [];

  List<Song> get items {
    return _items;
  }

  List<Song> get itemsArtist {
    return _itemArtist;
  }

  Future<void> fetchHomeSong() async {
    try {
      final url =
          Uri.parse('https://conkhunglongnene.site/song?size=20&page=1');
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        print('error');
        return;
      }

      final List<Song> loadedSong = [];
      responseData['data']['rows'].forEach((value) {
        loadedSong.add(Song(value['id'],
            'https://conkhunglongnene.site' + value['image'], value['name']));
      });
      _items = loadedSong;
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> fetchSongofArtist(int id) async {
    try {
      final url = Uri.parse('https://conkhunglongnene.site/song/artist/$id');
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        print('khong lay dc bai hat tu nghe si co id=$id');
      }
      final List<Song> loadedSongs = [];

      responseData['data'].forEach((song) {
        loadedSongs.add(Song(song['id'],
            'https://conkhunglongnene.site' + song['image'], song['name']));
      });
      _itemArtist = loadedSongs;
    } catch (err) {
      print(err.toString());
    }
  }
}
