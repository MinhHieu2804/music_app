import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/widgets/audio_controller.dart';
import 'package:provider/provider.dart';

class SongDetailScreen extends StatelessWidget {
  static final String routeName = '/songdetail';
  const SongDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var song = Provider.of<PlayingSong>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 50, maxWidth: 250),
          child: Column(children: [
            Text(
              song.name,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...song.artists.map((e) {
                  String add = " & ";
                  if (e == song.artists.last) {
                    add = "";
                  }
                  return Text(e.name + add,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 19));
                })
              ],
            ),
          ]),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 28),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  song.image as String,
                  height: 345,
                  width: 346,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          AudioController(),
        ],
      ),
    );
  }
}
