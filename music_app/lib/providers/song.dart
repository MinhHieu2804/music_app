import 'package:flutter/foundation.dart';
import 'package:music_app/providers/artist.dart';

class Song with ChangeNotifier {
  final int id;
  final String image;
  final String? source;
  final String name;
  final List<Artist>? artists;

  Song(this.id, this.image, this.name, {this.source, this.artists});
}
