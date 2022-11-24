import 'package:flutter/material.dart';
import 'package:music_app/screens/likes_screen.dart';
import 'package:music_app/screens/playlist_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController control;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Library',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: control,
                isScrollable: true,
                tabs: [
                  Align(
                    alignment: Alignment.center,
                    child: Tab(
                      text: 'Playlists',
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Tab(
                      text: 'Likes',
                    ),
                  ),
                ],
                labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                unselectedLabelColor: Theme.of(context).secondaryHeaderColor,
                indicatorColor: Color(0xff4CD964),
                indicatorWeight: 6,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: control,
            children: [PlayListScreen(), LikeScreen()],
          ),
        ));
  }
}
