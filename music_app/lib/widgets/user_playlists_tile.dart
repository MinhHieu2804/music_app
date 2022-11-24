import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/providers/auth.dart';
import 'package:music_app/providers/playlist.dart';
import 'package:provider/provider.dart';

class UserPlaylistsTile extends StatelessWidget {
  const UserPlaylistsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var playlist = Provider.of<Playlist>(context, listen: false);

    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.listUl,
                color: Color(0xff4CD964),
              ),
              title: Text(
                playlist.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                color: Colors.red,
                iconSize: 15,
                icon: FaIcon(FontAwesomeIcons.x),
                onPressed: () {
                  Provider.of<Auth>(context, listen: false)
                      .deletePlaylist(playlist.id);
                },
              ),
            )),
      ),
    );
  }
}
