import 'package:flutter/material.dart';
import 'package:music_app/providers/auth.dart';
import 'package:music_app/widgets/user_playlists_tile.dart';
import 'package:provider/provider.dart';

class UserPlaylist extends StatefulWidget {
  @override
  State<UserPlaylist> createState() => _UserPlaylistState();
}

class _UserPlaylistState extends State<UserPlaylist> {
  @override
  Widget build(BuildContext context) {
    var playlists = Provider.of<Auth>(context).playlists;

    return playlists.isEmpty
        ? Expanded(
            child: Center(
              child: Text(
                'Add some playlist',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          )
        : Expanded(
            child: ListView(
              children: [
                ...playlists.map((e) => ChangeNotifierProvider.value(
                      value: e,
                      child: UserPlaylistsTile(),
                    ))
              ],
            ),
          );
  }
}
