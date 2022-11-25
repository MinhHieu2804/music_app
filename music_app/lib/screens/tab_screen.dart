import 'package:flutter/material.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/providers/screen.dart';
import 'package:music_app/screens/artist_song_list_screen.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/screens/library_screen.dart';
import 'package:music_app/screens/playlist_songs_screen.dart';
import 'package:music_app/screens/profile_screen.dart';
import 'package:music_app/screens/search_sreen.dart';
import 'package:music_app/screens/song_detail_screen.dart';
import 'package:music_app/screens/songs_list.dart';
import 'package:music_app/widgets/login_form.dart';
import 'package:music_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  bool isPlaying = true;
  bool isSong = false;

  @override
  void initState() {
    setState(() {
      isSong = false;
      isPlaying = true;
    });
    _pages = [
      {
        'page': HomeSreen(),
        'title': 'Home',
      },
      {
        'page': SearchScreen(),
        'title': 'Search',
      },
      {
        'page': LibraryScreen(),
        'title': 'Library',
      },
      {
        'page': Profile(),
        'title': 'Account',
      },
      {
        'page': SongLists(),
        'title': 'SongLists',
      },
      {
        'page': ArtistSongListScreen(),
        'title': 'artistSongLists',
      },
      {
        'page': PlaylistSongsScreen(),
        'title': 'playListSongs',
      },
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      Provider.of<Screen>(context, listen: false)
          .setCurrentScreen(index, "", -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var playingSong = Provider.of<PlayingSong>(context);
    int i = context.watch<Screen>().currentScreen;
    // _pages[4] = {
    //   'page': SongLists(),
    //   'title': 'SongLists',
    // };
    return Scaffold(
      body: _pages[i]['page'] as Widget,
      bottomSheet: playingSong.id != null
          ? InkWell(
              onTap: () {
                Navigator.pushNamed(context, SongDetailScreen.routeName);
              },
              child: Container(
                height: 70,
                width: double.infinity,
                margin: EdgeInsets.only(right: 5, left: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).secondaryHeaderColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          child: Image.network(
                            playingSong.image as String,
                            width: 72,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.only(left: 8, top: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  playingSong.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text('Artist')
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        if (playingSong.isPlaying) {
                          playingSong.pause();
                        } else {
                          playingSong.resume();
                        }
                        await playingSong.changeState();
                        setState(() {
                          isPlaying = playingSong.isPlaying;
                        });
                      },
                      icon: Icon(playingSong.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      iconSize: 40,
                    )
                  ],
                ),
              ),
            )
          : null,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            iconSize: 40,
            onTap: _selectPage,
            unselectedItemColor: Theme.of(context).accentColor,
            selectedItemColor: Colors.black,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.library_music),
                label: 'Your Library',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.account_circle_outlined),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
