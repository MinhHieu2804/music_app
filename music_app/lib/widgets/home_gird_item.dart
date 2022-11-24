import 'package:flutter/material.dart';
import 'package:music_app/screens/song_detail_screen.dart';
import 'package:music_app/screens/songs_list.dart';
import 'package:provider/provider.dart';

import '../providers/screen.dart';

class HomeGridItem extends StatelessWidget {
  String imageUrl;
  String name;
  HomeGridItem(this.imageUrl, this.name);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
                imageUrl,
                width: 50,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
