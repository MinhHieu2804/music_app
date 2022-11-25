import 'dart:ffi';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:music_app/providers/songs.dart';
import 'package:music_app/widgets/song_grid.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/screen.dart';

class SongLists extends StatefulWidget {
  static final String routeName = '/songlist';

  @override
  State<SongLists> createState() => _SongListsState();
}

class _SongListsState extends State<SongLists> {
  bool _isInnit = true;
  bool _isLoading = false;

  Future<void> getData() async {
    await Provider.of<Songs>(context, listen: false)
        .fetchAlbumSongs(Provider.of<Screen>(context, listen: false).albumId);
  }

  @override
  void initState() {
    if (_isInnit) {
      setState(() {
        _isLoading = true;
      });
      getData().then((value) {
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
    var album = Provider.of<Screen>(context, listen: false);
    var items = Provider.of<Songs>(context).itemAlbum;
    print(items.length);
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
      body: SafeArea(
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  album.albumName,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
              )),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 3,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 30,
                        ),
                        itemCount: items.length,
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: items[i],
                              child: SongListItem(),
                            )),
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
