import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/providers/album.dart';

class Albums with ChangeNotifier {
  List<Album>? items;

  Future<void> fetchAlbum() async {
    try {
      final url =
          Uri.parse('https://conkhunglongnene.site/album?page=1&size=50');
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        log('khong the lay danh sach album');
        return;
      }
      List<Album> loadedAlbum = [];
      responseData['data']['rows'].forEach((al) {
        loadedAlbum.add(Album(al['id'],
            'https://conkhunglongnene.site' + al['cover'], al['name']));
      });
      items = loadedAlbum;
    } catch (err) {
      log(err.toString());
    }
  }
}
