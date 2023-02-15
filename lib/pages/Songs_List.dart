// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:streamer/helpers/helpers.dart';
import 'package:streamer/player.dart';
import 'package:streamer/subsonic/context.dart';
import 'package:streamer/subsonic/requests/get_album.dart';
import 'package:streamer/subsonic/requests/requests.dart';
import 'package:streamer/subsonic/requests/stream_id.dart';
import 'package:streamer/subsonic/response.dart';
import 'package:streamer/subsonic/subsonic.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key, required this.subSonicContext});
  final subSonicContext;

  @override
  State<SongsList> createState() => _SongsList();
}

class _SongsList extends State<SongsList> {
  final AudioPlayer _player = AudioPlayer();
  List<SongResult> songList = [];

  @override
  void initState() {
    super.initState();
    _fetchAllSongs();
  }

  Future<void> _fetchAllSongs() async {
    final albumList =
        await GetAlbumList2(type: GetAlbumListType.alphabeticalByArtist)
            .run(widget.subSonicContext)
            .catchError((err) {
      debugPrint('error: network issue? $err');
      // errorMessage = err.toString();
      return Future.value(SubsonicResponse(
        ResponseStatus.failed,
        "Network issue",
        '',
      ));
    });

    if (albumList.status == ResponseStatus.ok) {
      for (var album in albumList.data) {
        final fetchedAlbum = await GetAlbum(album.id)
            .run(widget.subSonicContext)
            .catchError((err) {
          debugPrint('error: network issue? $err');
          // errorMessage = err.toString();
          return Future.value(SubsonicResponse(
            ResponseStatus.failed,
            "Network issue",
            '',
          ));
        });

        if (fetchedAlbum.status == ResponseStatus.ok) {
          for (var song in fetchedAlbum.data.songs) {
            setState(() {
              songList.add(song);
            });
          }
        }
      }
    }

    songList.sort();
    for (var song in songList) {
      debugPrint("song: ${song.artistName}");
    }
    setState(() {});
  }

  Future<void> _playNowPlaying(String songID) async {

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Player(
              url: songID,
              key: null,
            ),),);
  }

  @override
  Widget build(BuildContext context) {
    final double HeightS = MediaQuery.of(context).size.height;
    final double WidthS = MediaQuery.of(context).size.width;
    final player = AudioPlayer();

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            iconSize: 50,
            unselectedItemColor: Color.fromARGB(255, 137, 11, 11),
            selectedItemColor: Colors.green[700],
            currentIndex: 2,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music), label: "Library"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Library")
            ]),
        backgroundColor: Color.fromARGB(148, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          elevation: 0.0,
          title: const Text(
            "Your Songs (draft)",
          ),
        ),
        body: FutureBuilder<String>(
          future:
              DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
          // future: rootBundle.loadString("AssetManifest.json")
          builder: (context, item) {
            if (item.hasData) {
              Map? jsonMap = json.decode(item.data!);
              // List? songs = jsonMap?.keys.toList();

              return ListView.builder(
                itemCount: songList.length,
                itemBuilder: (context, index) {
                  var title = songList[index].artistName;

                  return Container(
                    margin: const EdgeInsets.only(
                        top: 0.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(185, 21, 40, 54),
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.download),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      textColor: Color.fromARGB(204, 11, 170, 14),
                      title: Text(
                        title,
                      ),
                      // subtitle:
                      // Text("path: ${path.substring(13, path.length - 4)}",
                      //     style: const TextStyle(
                      //       color: Colors.white70,
                      //       fontSize: 12.0,
                      //     )),
                      leading: Image.asset(
                        "assets/pato2.png",
                      ),
                      onTap: () async {
                        // await player.pause();
                        final streamURL = StreamItem(
                                songList[index].id.toString(),
                                streamFormat: StreamFormat.mp3)
                            .getDownloadUrl(widget.subSonicContext);

                        debugPrint("stream url: $streamURL");

                        _playNowPlaying(streamURL);
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Songs Found"));
            }
          },
        ));
  }
}
