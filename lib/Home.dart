import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:streamer/Player.dart';
import 'package:streamer/model/nowPlayingResponse.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import 'helpers/helpers.dart';

class Home extends StatefulWidget {
  final NowPlaying nowPlaying;

  const Home({Key? key, required this.nowPlaying}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late NowPlaying nowPlaying;

  @override
  Widget build(BuildContext context) {
    nowPlaying = widget.nowPlaying;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Now playing",
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 20,
          ),
          SelectableText(
            "Artist: ${nowPlaying.subsonicResponse.nowPlaying.entry.artist.toString()}",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SelectableText(
            "Artist: ${nowPlaying.subsonicResponse.nowPlaying.entry.title.toString()}",
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: _playNowPlaying,
            style: ElevatedButton.styleFrom(
                minimumSize: Size(80, 60),
                backgroundColor: Colors.purple.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45))),
            child: const Text(
              "Play nowPlaying",
              style: TextStyle(
                color: Color.fromARGB(222, 24, 167, 214),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _playNowPlaying() async {
    String random = generateRandomString(7);
    String token = makeToken("Faridonaka48@", random);

    const id = 'ab';

    final currentSong =
        'http://localhost:4533/rest/stream.view?u=machinegun&t=$token&s=$random&v=1.61.0&c=streamer%id=${widget.nowPlaying.subsonicResponse.nowPlaying.entry.id.toString()}';
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Player(
              url: currentSong,
              key: null,
            )));
  }
}
