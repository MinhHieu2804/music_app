import 'package:flutter/material.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/widgets/searched_song.dart';
import 'package:provider/provider.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    var history = Provider.of<PlayingSong>(context).history.toList().reversed;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...history.map((e) {
              return ChangeNotifierProvider.value(
                value: e,
                child: SearchedSong(),
              );
            }),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
