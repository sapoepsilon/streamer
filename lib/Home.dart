import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:streamer/Player.dart';
import 'package:streamer/subsonic/context.dart';
import 'package:streamer/subsonic/requests/get_artists.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import 'helpers/helpers.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.subSonicContext}) : super(key: key);
  final subSonicContext;

  @override
  _HomeState createState() => _HomeState();
}

void fetchArtist(subSonicContext) async {
  final artists = await GetArtistsRequest().run(subSonicContext);

  artists.data;
  for (var artist in artists.data.index) {
    print("artist name ${artist.name} artist: ${artist.artist} \n");
  }
}

class _HomeState extends State<Home> {
  late List<Artist> artists;
  @override
  Widget build(BuildContext context) {
    fetchArtist(widget.subSonicContext);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: ElevatedButton(
          onPressed: () {},
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
          // SelectableText(
          //   "Artist: ${nowPlaying.subsonicResponse.nowPlaying.entry.artist.toString()}",
          //   style: TextStyle(fontSize: 20),
        
          const SizedBox(
            height: 20,
          ),
          // SelectableText(
          //   // "Artist: ${nowPlaying.subsonicResponse.nowPlaying.entry.title.toString()}",
          //   style: TextStyle(fontSize: 20),
          // ),
        ],
      ),
    );
  }

//   Future<void> _playNowPlaying() async {
//     String random = generateRandomString(7);
//     String token = makeToken("Faridonaka48@", random);

//     const id = 'ab';
// // TODO: Use new API to play songs
//     final currentSong =
//         'http://localhost:4533/rest/stream.view?u=machinegun&t=$token&s=$random&v=1.61.0&c=streamer%id=${widget.nowPlaying.subsonicResponse.nowPlaying.entry.id.toString()}';
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => Player(
//               url: currentSong,
//               key: null,
//             )));
//   }
}
