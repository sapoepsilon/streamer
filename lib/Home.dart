import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:streamer/Player.dart';
import 'package:streamer/model/getArtistsResponse.dart';
import 'package:streamer/model/nowPlayingResponse.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import 'helpers/helpers.dart';

class Home extends StatefulWidget {
  final GetArtists getArtists;

  const Home({Key? key, required this.getArtists}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GetArtists getArtists;

  @override
  Widget build(BuildContext context) {
    getArtists = widget.getArtists;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: ElevatedButton(
          onPressed: something,
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
      body: ListView.builder(
        itemCount: getArtists.subsonicResponse.artists.index.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(getArtists.subsonicResponse.artists.index[index].artist.name));
        },
      )
    );
  }

  void something() {
    print("something");
  }


  // Future<void> _playNowPlaying() async {
  //   String random = generateRandomString(7);
  //   String token = makeToken("Faridonaka48@", random);
  //
  //   print(
  //       "user agent id: ${nowPlaying.subsonicResponse.nowPlaying.entry.playerId}");
  //   print(
  //       "user agent name: ${nowPlaying.subsonicResponse.nowPlaying.entry.playerName}");
  //
  //   const id = 'ab';
  //
  //   final currentSong =
  //       widget.nowPlaying.subsonicResponse.nowPlaying.entry.id.toString();
  //   print("id: ${nowPlaying.subsonicResponse.nowPlaying.entry.id}");
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => Player(
  //             url:
  //                 "http://100.91.82.12:4533/rest/stream.view?u=machinegun&t=67154ac6fc995066b1bf6e4486a73d38&s=tZplde%5C&v=1.61.0&c=streamer&id=${currentSong}",
  //             key: null,
  //           ))
  //   );
  //
  //
  // }
}
