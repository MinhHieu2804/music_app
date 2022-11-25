import 'package:flutter/material.dart';
import 'package:music_app/providers/playing_song.dart';
import 'package:music_app/providers/screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          //for circle avtar image
          _getHeader(),
          SizedBox(
            height: 10,
          ),
          _profileName(Provider.of<Auth>(context, listen: false).userName),
          SizedBox(
            height: 14,
          ),
          _heading("Personal Details"),
          _detailsCard(),
          logoutButton()
        ],
      )),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                        "https://p.kindpng.com/picc/s/21-210072_man-wearing-headphones-silhouette-hd-png-download.png"))
                // color: Colors.orange[100],
                ),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(
          name == null ? "User" : name,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          heading,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: Icon(Icons.email),
              title: Text(Provider.of<Auth>(context, listen: false).userEmail),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('ID: ' +
                  Provider.of<Auth>(context, listen: false).userId.toString()),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("SomeWhere"),
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        Provider.of<PlayingSong>(context, listen: false).clear();
        Provider.of<Screen>(context, listen: false).setCurrentScreen(0, "", -1);
        Provider.of<Auth>(context, listen: false).logout();
      },
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 79, 190, 97),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(horizontal: 10),
          // color: Color.fromARGB(255, 79, 190, 97),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
}
