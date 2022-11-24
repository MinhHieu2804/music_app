import 'package:flutter/foundation.dart';
import 'package:music_app/providers/song.dart';

class Playlist with ChangeNotifier {
  final int id;
  final String name;
  final List<Song>? playListItem;

  Playlist(this.id, this.name, {this.playListItem});
}
