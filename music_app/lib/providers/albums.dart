import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/providers/album.dart';

class Albums with ChangeNotifier {
  List<Album>? items;

  Future<void> fetchAlbum() async {
    try {
      final url = Uri.parse('http://10.0.2.2:3001/album?page=1&size=50');
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData['status'] > 200) {
        log('khong the lay danh sach album');
        return;
      }
      List<Album> loadedAlbum = [];
      responseData['data']['rows'].forEach((al) {
        loadedAlbum.add(
            Album(al['id'], 'http://10.0.2.2:3001' + al['cover'], al['name']));
      });
      items = loadedAlbum;
    } catch (err) {
      log(err.toString());
    }
  }
}
