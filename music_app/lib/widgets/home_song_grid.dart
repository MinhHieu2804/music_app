import 'package:flutter/material.dart';
import 'package:music_app/providers/songs.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

class HomeSongGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context).items;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: SafeArea(
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(bottom: 17),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Songs you may like",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              )),
          Container(
            child: GridView.builder(
              itemCount: songs.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 3,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
              ),
              shrinkWrap: true,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: songs[i], child: SongListItem()),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ]),
      ),
    );
  }
}
