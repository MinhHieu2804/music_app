import 'package:flutter/material.dart';
import 'package:music_app/providers/album.dart';
import 'package:music_app/screens/song_detail_screen.dart';
import 'package:music_app/screens/songs_list.dart';
import 'package:provider/provider.dart';

import '../providers/screen.dart';

class HomeGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var albumitem = Provider.of<Album>(context, listen: false);
    return InkWell(
      onTap: () async {
        await Provider.of<Screen>(context, listen: false)
            .setAlbum(albumitem.id, albumitem.name);
        Provider.of<Screen>(context, listen: false).setCurrentScreen(4, "", -1);

        // Navigator.pushNamed(context, SongLists.routeName, arguments: name);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).accentColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              child: Image.network(
                albumitem.cover,
                width: 50,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Text(
                  albumitem.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
