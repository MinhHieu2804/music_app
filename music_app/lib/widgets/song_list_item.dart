import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/providers/screen.dart';
import 'package:music_app/providers/search.dart';
import 'package:music_app/providers/song.dart';
import 'package:music_app/screens/login_screen.dart';
import 'package:music_app/screens/song_detail_screen.dart';
import 'package:provider/provider.dart';

class SongListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var song = Provider.of<Song>(context, listen: false);
    var link = song.image;
    return GestureDetector(
      onTap: () async {
        await Provider.of<PlayingSong>(context, listen: false)
            .setPlayingSong(song.id);
        Navigator.pushNamed(context, SongDetailScreen.routeName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            song.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    song.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  'Artist',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
