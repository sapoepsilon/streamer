import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            color: Colors.black45),
      ),
      ),),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF701ebd),
              Color(0xFF873bcc),
              Color(0xFFfe4a97),
              Color(0xFFe17763),
              Color(0xFF68998c),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

      child: isFetching
          ? loading()
          : ListView.builder(
          itemCount: playlistList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.list),
                trailing:  Text(
                  "My Playlist $index",
                  style: const TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text(
                  playlistList[index].name,
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
            );
          }),
    ),
    );
  }
}