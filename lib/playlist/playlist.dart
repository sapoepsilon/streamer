import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:streamer/playlist/playlist_view_model.dart';
import 'package:streamer/repository/MusicBrainz/mbid.dart';
import 'package:streamer/subsonic/context.dart';
import 'package:streamer/subsonic/requests/get_album.dart';
import 'package:streamer/subsonic/requests/get_cover_art.dart';
import 'package:streamer/subsonic/requests/get_playlist.dart';
import 'package:streamer/subsonic/requests/get_playlists.dart';
import 'package:streamer/subsonic/response.dart';

import '../helpers/helpers.dart';

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

  @override
  void initState() {
    fetchPlaylist();
  }

  Future<void> fetchPlaylist() async {
    var playlists = await GetPlaylists().run(widget.ctx).catchError((err) {
      debugPrint('error: network issue? $err');
      return Future.value(SubsonicResponse(
        ResponseStatus.failed,
        "Network issue",
        '',
      ));
    });

    if (playlists.status == ResponseStatus.ok) {
      playlistList = playlists.data.playlists;
      setState(() {
        isFetching = false;
      });
    }
  }

  Future<Widget> fetchFirstSongArtFromPlaylist(String playlistID) async {
    var fetchError = "";
    var playlist =
        await GetPlaylistRequest(playlistID).run(widget.ctx).catchError((err) {
      debugPrint('error: network issue? $err');
      fetchError = err;
      return Future.value(SubsonicResponse(
        ResponseStatus.failed,
        "Network issue",
        '',
      ));
    });

    if (playlist.status == ResponseStatus.failed) {
      debugPrint("Failed to fetch: ${fetchError}");
    }
    String mbid = await fetchMBID(playlist.data.entries.first.title,
            playlist.data.entries.first.artistName) ??
        "";
    var albumURL = await fetchAlbumArtURL(mbid) ?? "";
    var coverArtObject = GetCoverArt(playlist.data.entries.first.id)
        .run(widget.ctx)
        .catchError((err) {
      debugPrint('error: network issue? $err');
      return Future.value(SubsonicResponse(
        ResponseStatus.failed,
        "Network issue",
        '',
      ));
    });

    return Image.network(albumURL);
  }

  FutureBuilder playlistAlbumArt(String playlistID) {
    return FutureBuilder(
      future: fetchFirstSongArtFromPlaylist(playlistID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("snapshot has data:");
          return snapshot.data as Widget;
        } else {
          print("snapshot does not have data:");
          return const Icon(
            Icons.question_mark_outlined,
            color: Colors.grey,
            size: 24.0,
          );
        }
      },
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF701ebd),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "Playlists",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
        ),
      ),
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
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Column(children: [
                      ContainerWithHeartButton(
                        playlistImage: playlistAlbumArt(playlistList[0].id),
                        playlistID: playlistList[0].id, ctx: widget.ctx,
                      ),
                      Text(
                        playlistList[0].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ]),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          scrollDirection: Axis.vertical,
                          physics: const PageScrollPhysics(),
                          itemCount: playlistList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index == 0
                                ? const SizedBox.shrink()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        ListTile(
                                          title: Text(
                                            playlistList[index].name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          leading: playlistAlbumArt(
                                              playlistList[index].id),
                                          subtitle: Text(
                                            " songs: ${playlistList[index].songCount}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ]);
                          }),
                    ),
                    const Spacer(),
                  ],
                )),
    );
  }
}
