import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/providers/auth.dart';
import 'package:music_app/widgets/user_playlists.dart';
import 'package:provider/provider.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  bool _isInnit = true;
  bool _isLoading = false;

  Future<void> getData() async {
    await Provider.of<Auth>(context, listen: false).fetchPlaylists();
  }

  @override
  void initState() {
    if (_isInnit) {
      setState(() {
        _isLoading = true;
      });

      getData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInnit = false;
    super.initState();
  }

  void showCreateDialog(BuildContext context) {
    var newPlaylist = TextEditingController();
    var formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Center(child: const Text('Create new playlist')),
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    controller: newPlaylist,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Playlist\'s name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (!formkey.currentState!.validate()) {
                      return;
                    }
                    Provider.of<Auth>(context, listen: false)
                        .createPlaylist(newPlaylist.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Create'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child: ListTile(
            leading: IconButton(
              onPressed: () => showCreateDialog(context),
              iconSize: 30,
              icon: const FaIcon(FontAwesomeIcons.squarePlus),
            ),
            title: const Text(
              'Create new playlist',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        _isLoading ? CircularProgressIndicator() : UserPlaylist(),
        SizedBox(height: 70),
      ]),
    );
  }
}
