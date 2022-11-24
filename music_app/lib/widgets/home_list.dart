import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/providers/artist.dart';
import 'package:music_app/widgets/artist_list_item.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/artists.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final artistList = Provider.of<Aritsts>(context).items;
    return Container(
      height: 230,
      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Artists you may like",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Container(
              height: 170,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: artistList.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: artistList[i],
                        child: ArtistListItem(),
                      ))),
        ],
      ),
    );
  }
}
