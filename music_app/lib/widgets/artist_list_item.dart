import 'package:flutter/material.dart';
import 'package:music_app/providers/artist.dart';
import 'package:provider/provider.dart';
import '../providers/screen.dart';

class ArtistListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final artist = Provider.of<Artist>(context, listen: false);
    var link = artist.imageUrl;
    return InkWell(
      onTap: () {
        Provider.of<Screen>(context, listen: false)
            .setCurrentScreen(5, artist.name, artist.id);
      },
      child: Column(
        children: [
          Container(
            height: 126,
            width: 126,
            margin: const EdgeInsets.only(left: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                link,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              artist.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
