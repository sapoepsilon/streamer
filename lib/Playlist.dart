import 'package:flutter/material.dart';
import 'package:streamer/subsonic/context.dart';
import 'package:streamer/subsonic/requests/get_playlist.dart';
import 'package:streamer/subsonic/requests/get_playlists.dart';
import 'package:streamer/subsonic/response.dart';

class PlaylistList extends StatefulWidget {
  const PlaylistList({super.key, required this.ctx});

  final SubsonicContext ctx;

  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  List<PlaylistResult> playlistList = [];
  bool isFetching = true;
  late var response;

  Future<void> fetchPlaylist() async {
    var playlists = await GetPlaylists().run(widget.ctx).catchError((err) {
      debugPrint('error: network issue? $err');
      return Future.value(SubsonicResponse(
        ResponseStatus.failed,
        "Network issue",
        '',
      ));
    });

    if(playlists.status == ResponseStatus.ok){
      playlistList = playlists.data.playlists;
      setState(() {
        isFetching = false;
      });
    }
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    fetchPlaylist();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF701ebd),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text("Playlists",
        style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white70),
      ),
      ),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.teal,
              Colors.black,
            ],
            radius: .8,
          ),
        ),

      child: isFetching
          ? loading()
          : ListView.builder(
          itemCount: playlistList.length,
          itemBuilder: (BuildContext context, int index ) {
            return ListTile(
                trailing:  Text(
                  "My Playlist ($index)",
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                title: Text(
                  playlistList[index].name,
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      height: 2.5,
                      color: Colors.white70),
                ),
              leading: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset(
                  "images/Cover2.jpg",
                  scale: 0.9,
                ),
            ),
            );
          }),
    ),
    );
  }
}