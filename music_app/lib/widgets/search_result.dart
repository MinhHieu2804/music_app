import 'package:flutter/material.dart';
import 'package:music_app/providers/search.dart';
import 'package:music_app/widgets/searched_song.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    var serchSongs = Provider.of<Search>(context).songItems;
    return serchSongs.isEmpty
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
            child: ListView.builder(
              itemCount: serchSongs.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: serchSongs[i],
                child: Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: SearchedSong(),
                ),
              ),
            ),
          );
  }
}
