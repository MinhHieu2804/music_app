import 'dart:developer';

import 'artist.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Aritsts with ChangeNotifier {
  late List<Artist> _items;

  List<Artist> get items {
    return [..._items];
  }

  Future<void> fetchArtistList() async {
    try {
      final url =
          Uri.parse('https://conkhunglongnene.site/artist?page=1&size=50');
      final response = await http.get(url);
      final reponseData = json.decode(response.body);
      if (reponseData['status'] > 200) {
        print(reponseData['message']);
        return;
      }
      final List<Artist> loadedArtists = [];
      reponseData['data']['rows'].forEach((value) {
        loadedArtists.add(Artist(value['id'],
            'https://conkhunglongnene.site' + value['image'], value['name']));
      });
      _items = loadedArtists;
    } catch (err) {
      log(err.toString());
    }
  }
}
