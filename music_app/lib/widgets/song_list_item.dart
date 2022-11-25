import 'package:flutter/material.dart';
import 'package:music_app/providers/playing_list.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/providers/screen.dart';
import 'package:music_app/providers/song.dart';
import 'package:music_app/providers/songs.dart';
import 'package:music_app/screens/song_detail_screen.dart';
import 'package:provider/provider.dart';

class SongListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var song = Provider.of<Song>(context, listen: false);

    var link = song.image;
    return GestureDetector(
      onTap: () async {
        if (Provider.of<Screen>(context, listen: false).currentScreen == 5) {
          Provider.of<PlayingList>(context, listen: false).setPlayingList(
              Provider.of<Songs>(context, listen: false).itemsArtist);
        } else if (Provider.of<Screen>(context, listen: false).currentScreen ==
            6) {
          Provider.of<PlayingList>(context, listen: false).setPlayingList(
              Provider.of<Songs>(context, listen: false).itemPlaylist);
        } else if (Provider.of<Screen>(context, listen: false).currentScreen ==
            4) {
          Provider.of<PlayingList>(context, listen: false).setPlayingList(
              Provider.of<Songs>(context, listen: false).itemAlbum);
        }
        await Provider.of<PlayingSong>(context, listen: false)
            .setPlayingSong(song.id);
        Provider.of<PlayingSong>(context, listen: false)
            .audioPlayer
            .onPlayerCompletion
            .listen((event) {
          if (Provider.of<PlayingSong>(context, listen: false).isReplay) {
            Provider.of<PlayingSong>(context, listen: false).setPlayingSong(
                Provider.of<PlayingSong>(context, listen: false).id as int);
          } else {
            int next = Provider.of<PlayingList>(context, listen: false)
                .getNextSong(
                    Provider.of<PlayingSong>(context, listen: false).id as int);
            Provider.of<PlayingSong>(context, listen: false)
                .setPlayingSong(next);
          }
        });
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
                song.artists == null
                    ? SizedBox()
                    : FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...song.artists!.map((e) {
                              String add = " & ";
                              if (e == song.artists!.last) {
                                add = "";
                              }
                              return Text(e.name + add,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 19));
                            })
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
