import 'package:flutter/foundation.dart';

class Artist with ChangeNotifier {
  final int id;
  final String imageUrl;
  final String name;

  Artist(this.id, this.imageUrl, this.name);

  Future<void> getArtistById(int id) async {
    print('object');
  }
}
