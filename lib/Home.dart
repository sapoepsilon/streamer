import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:streamer/Player/Player.dart';
import 'package:streamer/model/nowPlayingResponse.dart';
import 'package:streamer/model/nowPlayingResponseSingle.dart' as list;
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import 'helpers/helpers.dart';

class Home extends StatefulWidget {
  final Entry nowPlaying;
  final String server;

  const Home({Key? key, required this.nowPlaying, required this.server})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Entry nowPlaying;

  @override
  Widget build(BuildContext context) {
    nowPlaying = widget.nowPlaying;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: ElevatedButton(
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
      ),
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
            "Artist: ${nowPlaying.artist.toString()}",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SelectableText(
            "Artist: ${nowPlaying.title.toString()}",
            style: const TextStyle(fontSize: 20),
          ),
          SelectableText("Genre: ${nowPlaying.genre}")
        ],
      ),
    );
  }

  Future<void> _playNowPlaying() async {
    String random = generateRandomString(7);
    String token = makeToken("Faridonaka48@", random);

    const id = 'ab';

    final currentSong =
        'http://${widget.server}/rest/stream.view?u=machinegun&t=$token&s=$random&v=1.61.0&c=streamer&id=${widget.nowPlaying.id.toString()}';
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Player(
              url: currentSong,
              serverURL: widget.server,
              songID:
                  widget.nowPlaying.coverArt,
              albumName: widget.nowPlaying.album,
              key: null,
            )));
  }
}
