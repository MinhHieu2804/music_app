import 'package:flutter/material.dart';
import 'package:music_app/providers/albums.dart';
import 'package:music_app/providers/artist.dart';
import 'package:music_app/providers/artists.dart';
import 'package:music_app/providers/playing_list.dart';
import 'package:music_app/providers/songs.dart';
import 'package:music_app/widgets/home_grid.dart';
import 'package:music_app/widgets/home_list.dart';
import 'package:music_app/widgets/home_song_grid.dart';
import 'package:music_app/widgets/song_grid.dart';
import 'package:provider/provider.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({Key? key}) : super(key: key);

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  var _isInnit = true;
  var _isLoading = false;

  Future<void> fetchData() async {
    await Provider.of<Aritsts>(context, listen: false).fetchArtistList();
    await Provider.of<Songs>(context, listen: false).fetchHomeSong();
    await Provider.of<Albums>(context, listen: false).fetchAlbum();
    Provider.of<PlayingList>(context, listen: false)
        .setPlayingList(Provider.of<Songs>(context, listen: false).items);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (_isInnit) {
      setState(() {
        _isLoading = true;
      });
      fetchData().then((_) {
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
        title: Text(
          'Wellcome',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView(
                children: [HomeGrid(), HomeList(), HomeSongGrid()],
              ),
            ),
    );
  }
}
