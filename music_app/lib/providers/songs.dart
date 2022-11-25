import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:music_app/providers/artist.dart';
import 'package:music_app/providers/auth.dart';
import 'package:music_app/providers/song.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const URL = 'https://conkhunglongnene.site';

class Songs with ChangeNotifier {
  List<Song> _items = [];
  List<Song> _itemArtist = [];
  List<Song> _itemPlaylist = [];
  List<Song> _itemsAlbum = [];

  List<Song> get items {
    return _items;
  }

  List<Song> get itemsArtist {
    return _itemArtist;
  }

  List<Song> get itemPlaylist {
    return _itemPlaylist;
  }

  List<Song> get itemAlbum {
    return _itemsAlbum;
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
        List<Artist> artistsT = [];
        value['artists'].forEach((v) {
          artistsT.add(Artist(v['id'],
              'https://conkhunglongnene.site' + v['image'], v['name']));
        });
        loadedSong.add(
          Song(value['id'], 'https://conkhunglongnene.site' + value['image'],
              value['name'],
              artists: artistsT),
        );
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

  Future<void> fetchPlaylistSong(int id, BuildContext context) async {
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      final url =
          Uri.parse('https://conkhunglongnene.site/playlist/details/$id');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ' + token,
      });
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        print('khong lay dc bai hat tu nghe si co id=$id');
      }
      print(responseData);
      final List<Song> loadedSongs = [];
      responseData['data'].forEach((song) {
        loadedSongs.add(Song(song['id'],
            URL + '/public/images/artist_default.jpg', song['name']));
      });
      _itemPlaylist = loadedSongs;
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> fetchAlbumSongs(int id) async {
    try {
      final url = Uri.parse('https://conkhunglongnene.site/album/details/$id');
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        print('khong lay dc bai hat tu album co id=$id');
      }
      final List<Song> loadedSongs = [];
      responseData['data'].forEach((song) {
        loadedSongs.add(Song(song['id'], URL + song['image'], song['name']));
      });
      _itemsAlbum = loadedSongs;
    } catch (err) {
      log(err.toString());
    }
  }
}
