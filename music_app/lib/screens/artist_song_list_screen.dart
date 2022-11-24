import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:music_app/widgets/song_grid.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/screen.dart';
import '../providers/songs.dart';

class ArtistSongListScreen extends StatefulWidget {
  static final String routeName = '/artistsonglist';

  @override
  State<ArtistSongListScreen> createState() => _ArtistSongListScreenState();
}

class _ArtistSongListScreenState extends State<ArtistSongListScreen> {
  var _isInnit = true;
  var _isLoading = false;

  @override
  void initState() {
    if (_isInnit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Songs>(context, listen: false)
          .fetchSongofArtist(
              Provider.of<Screen>(context, listen: false).artistId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInnit = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context, false);
            Provider.of<Screen>(context, listen: false)
                .setCurrentScreen(0, "", -1);
          },
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          iconSize: 35,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Provider.of<Screen>(context, listen: false).artistName,
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    )),
                SongGrid(),
                SizedBox(
                  height: 50,
                )
              ]),
            ),
    );
  }
}
