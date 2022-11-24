import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:music_app/providers/artist.dart';
import 'package:http/http.dart' as http;

const URL = 'https://conkhunglongnene.site';

class PlayingSong with ChangeNotifier {
  int? id;
  String? image;
  String name = "";
  String? source;
  List<Artist> artists = [];
  bool isPlaying = false;
  bool isShuffle = false;
  bool isReplay = false;
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = Duration(seconds: 0);
  Duration position = Duration(seconds: 0);

  Future<void> setPlayingSong(int id) async {
    final url = Uri.parse('https://conkhunglongnene.site/song/$id');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    if (responseData['status'] > 200) {
      print('Khong the phat bai hat co id=$id');
    }
    this.id = responseData['data']['id'];
    image = URL + responseData['data']['image'];
    name = responseData['data']['name'];
    source = URL + responseData['data']['src'];
    final List<Artist> loadedA = [];
    responseData['data']['artists'].forEach((value) {
      loadedA.add(Artist(value['id'], URL + value['image'], value['name']));
    });
    artists = loadedA;
    isPlaying = true;
    play();
    notifyListeners();
  }

  Future<void> play() async {
    int result = await audioPlayer.play(this.source as String, volume: 10);
    if (result == 1) {
      print(this.source);
    } else {
      print('loi audio');
    }
  }

  Future<void> pause() async {
    int result = await audioPlayer.pause();
  }

  Future<void> resume() async {
    int result = await audioPlayer.resume();
  }

  Future<void> changeState() async {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  Duration getDuration() {
    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
    });
    notifyListeners();
    return duration;
  }

  Duration getPosition() {
    audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
    });
    notifyListeners();
    return position;
  }
}
