import 'package:flutter/material.dart';
import 'package:music_app/providers/albums.dart';
import 'package:music_app/providers/artists.dart';
import 'package:music_app/providers/auth.dart';
import 'package:music_app/providers/playing_list.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/providers/playlists.dart';
import 'package:music_app/providers/screen.dart';
import 'package:music_app/providers/search.dart';
import 'package:music_app/providers/songs.dart';
import 'package:music_app/screens/artist_song_list_screen.dart';
import 'package:music_app/screens/login_screen.dart';
import 'package:music_app/screens/playlist_songs_screen.dart';
import 'package:music_app/screens/song_detail_screen.dart';
import 'package:music_app/screens/songs_list.dart';
import 'package:music_app/screens/tab_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Screen()),
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: Aritsts()),
          ChangeNotifierProvider.value(value: Songs()),
          ChangeNotifierProvider.value(value: PlayingSong()),
          ChangeNotifierProvider.value(value: Search()),
          ChangeNotifierProvider.value(value: Playlists()),
          ChangeNotifierProvider.value(value: Albums()),
          ChangeNotifierProvider.value(value: PlayingList()),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color.fromARGB(255, 196, 196, 196),
              accentColor: Color.fromRGBO(75, 75, 75, 1),
              secondaryHeaderColor: Color(0xffc4c4c4),
              scaffoldBackgroundColor: Color.fromRGBO(247, 247, 247, 1),
            ),
            home: auth.isAuth
                ? TabScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? CircularProgressIndicator()
                            : LoginScreen(),
                  ),
            routes: {
              '/songdetail': (context) => SongDetailScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/songlist') {
                return MaterialPageRoute(builder: (_) => SongLists());
              }
              if (settings.name == '/artistsonglist') {
                return MaterialPageRoute(
                    builder: (_) => ArtistSongListScreen());
              }
              if (settings.name == '/playListSongs') {
                return MaterialPageRoute(builder: (_) => PlaylistSongsScreen());
              }
            },
          ),
        ));
  }
}
