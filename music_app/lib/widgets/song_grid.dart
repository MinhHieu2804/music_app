import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/song.dart';
import '../providers/songs.dart';

class SongGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = Provider.of<Songs>(context, listen: false).itemsArtist;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 30,
          ),
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: items[i],
            child: SongListItem(),
          ),
        ),
      ),
    );
  }
}
