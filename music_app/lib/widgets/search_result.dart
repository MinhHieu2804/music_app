import 'package:flutter/material.dart';
import 'package:music_app/providers/search.dart';
import 'package:music_app/widgets/searched_artists.dart';
import 'package:music_app/widgets/searched_song.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    var searchSongs = Provider.of<Search>(context).songItems;
    var searchartist = Provider.of<Search>(context).artistItems;

    return searchSongs.isEmpty && searchartist.isEmpty
        ? const Expanded(
            child: Center(
              child: Text(
                'Search songs and artists',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        : Expanded(
            child: Container(
              height: 520,
              child: SingleChildScrollView(
                child: Column(children: [
                  ...searchartist.map((e) {
                    return ChangeNotifierProvider.value(
                      value: e,
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: SearchedArtist(),
                      ),
                    );
                  }),
                  ...searchSongs.map((e) {
                    return ChangeNotifierProvider.value(
                        value: e,
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: SearchedSong(),
                        ));
                  }),
                ]),
              ),
            ),
          );
  }
}
