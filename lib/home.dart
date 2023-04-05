// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:streamer/subsonic/requests/get_artists.dart';

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
    debugPrint("artist name ${artist.name} artist: ${artist.artist} \n");
  }
}

class _HomeState extends State<Home> {
  late List<Artist> artists;
  @override
  Widget build(BuildContext context) {
    fetchArtist(widget.subSonicContext);
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(80, 60),
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
      body: Column(
        children: const [
          SizedBox(
            height: 30,
          ),
          Text(
            "Now playing",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          // SelectableText(
          //   "Artist: ${nowPlaying.subsonicResponse.nowPlaying.entry.artist.toString()}",
          //   style: TextStyle(fontSize: 20),
          SizedBox(
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

//   Future<void> _playNowPlaying() async { // Check discord messenger
//     String random = generateRandomString(7);
//     String token = makeToken("Faridonaka48@", random);

//     const id = 'ab';
//     final currentSong =
//         'http://localhost:4533/rest/stream.view?u=machinegun&t=$token&s=$random&v=1.61.0&c=streamer%id=${widget.nowPlaying.subsonicResponse.nowPlaying.entry.id.toString()}';
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => Player(
//               url: currentSong,
//               key: null,
//             )));
//   }
}
