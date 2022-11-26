import 'package:flutter/foundation.dart';
import 'package:music_app/providers/auth.dart';
import 'package:music_app/providers/playlist.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const URL = 'http://10.0.2.2:3001';

class Playlists with ChangeNotifier {
  List<Playlist> _item = [];

  List<Playlist> get item => _item;

  Future<void> createPlaylist(String name) async {
    final url = Uri.parse('http://10.0.2.2:3001/playlist');
    final response = await http.post(url, body: {
      'name': name,
    });
  }
}
