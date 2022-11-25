import 'package:flutter/material.dart';
import 'package:music_app/providers/screen.dart';
import 'package:music_app/providers/songs.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

class PlaylistSongsScreen extends StatefulWidget {
  static const routeName = '/playListSongs';

  @override
  State<PlaylistSongsScreen> createState() => _PlaylistSongsScreenState();
}

class _PlaylistSongsScreenState extends State<PlaylistSongsScreen> {
  bool _isInnit = true;
  bool _isLoading = false;
  Future<void> getData(BuildContext context) async {
    int id = await Provider.of<Screen>(context, listen: false).playListId;
    await Provider.of<Songs>(context, listen: false)
        .fetchPlaylistSong(id, context);
  }

  @override
  void initState() {
    if (_isInnit) {
      setState(() {
        _isLoading = true;
      });

      getData(context).then((value) {
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
    var songs = Provider.of<Songs>(context).itemPlaylist;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          iconSize: 40,
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.keyboard_arrow_down_sharp),
          onPressed: () {
            Provider.of<Screen>(context, listen: false)
                .setCurrentScreen(2, "", -1);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : songs.isEmpty
              ? Center(
                  child: Text('No songs'),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 2 / 3),
                            itemCount: songs.length,
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                                  value: songs[i],
                                  child: SongListItem(),
                                )),
                      )
                    ],
                  ),
                ),
    );
  }
}
