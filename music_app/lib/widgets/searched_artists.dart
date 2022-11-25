import 'package:flutter/material.dart';

import 'package:music_app/providers/artist.dart';
import 'package:music_app/providers/screen.dart';
import 'package:provider/provider.dart';

import '../providers/playing_song.dart';
import '../providers/search.dart';
import '../providers/song.dart';
import '../screens/song_detail_screen.dart';

class SearchedArtist extends StatelessWidget {
  const SearchedArtist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var artist = Provider.of<Artist>(context, listen: false);
    return InkWell(
      onTap: () async {
        Provider.of<Screen>(context, listen: false)
            .setCurrentScreen(5, artist.name, artist.id);
        // Navigator.pushNamed(context, SongDetailScreen.routeName);
        Provider.of<Search>(context, listen: false).emptySearch();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              artist.imageUrl,
              width: 50,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(artist.name),
        ),
      ),
    );
  }
}
