import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/playing_song.dart';
import '../providers/search.dart';
import '../providers/song.dart';
import '../screens/song_detail_screen.dart';

class SearchedSong extends StatelessWidget {
  const SearchedSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var song = Provider.of<Song>(context, listen: false);
    return InkWell(
      onTap: () async {
        await Provider.of<PlayingSong>(context, listen: false)
            .setPlayingSong(song.id);
        Navigator.pushNamed(context, SongDetailScreen.routeName);
        Provider.of<Search>(context, listen: false).emptySearch();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              song.image,
              width: 50,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(song.name),
        ),
      ),
    );
  }
}
