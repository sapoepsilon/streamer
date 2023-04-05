import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:streamer/helpers/colors.dart';
import 'package:streamer/helpers/custom_models/playing_song.dart';
import 'package:streamer/player.dart';
import 'package:streamer/subsonic/requests/download.dart';
import 'package:streamer/subsonic/requests/get_album.dart';
import 'package:streamer/subsonic/requests/requests.dart';
import 'package:streamer/subsonic/requests/star.dart';
import 'package:streamer/subsonic/requests/stream_id.dart';
import 'package:streamer/subsonic/subsonic.dart';
import 'package:streamer/utils/utils.dart';

import 'helpers/helpers.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key, required this.subSonicContext});

  final SubsonicContext subSonicContext;

  @override
  State<SongsList> createState() => _SongsList();
}

class _SongsList extends State<SongsList> {
  List<SongResult> songList = [];
  PlayingSong? playingSong;

  @override
  void initState() {
    super.initState();
    _fetchAllSongs();
  }

  FutureBuilder albumArt(SongResult song) {
    return FutureBuilder(
      future: getImageData(song),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return LoadingAnimationWidget.staggeredDotsWave(
            // LoadingAnimationwidget that call the
            color: Colors.green, // staggereddotwave animation
            size: 30,
          );
        }
      },
    );
  }

  Future<Widget> getImageData(SongResult song) async {
    String songURL =
        await getSongCoverFromITunes(song.artistName, song.title) ?? "";
    if (songURL == "") {
      return const Icon(
        Icons.question_mark_outlined,
        color: Colors.grey,
        size: 24.0,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.network(
            songURL,
            fit: BoxFit.fill,
            width: 50,
            height: 50,
          ),
        ),
      );
    }
  }

  Future<List<SongResult>> _fetchAllSongs() async {
    final albumList = await GetAlbumList2(
            type: GetAlbumListType.alphabeticalByArtist, size: 500)
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
              if (!songList.contains(song)) {
                songList.add(song);
              }
            });
          }
        }
      }
    }
    songList.sort();
    setState(() {});
    return songList;
  }

  Widget player(PlayingSong playingSong) {
    return Miniplayer(
        minHeight: 70,
        maxHeight: MediaQuery.of(context).size.height,
        valueNotifier: playingSong.isMiniPlayer == true
            ? ValueNotifier(MediaQuery.of(context).size.height)
            : ValueNotifier(70.0),
        builder: (height, percentage) {
          debugPrint("percentage $percentage");
          debugPrint("value notifier: ${height}}");
          if (percentage < 0.2) {
            return Player(
                url: playingSong.url,
                album: playingSong.album,
                artist: playingSong.artist,
                title: playingSong.title,
                isMiniPlayer: true);
          } else {
            return Player(
                url: playingSong.url,
                album: playingSong.album,
                artist: playingSong.artist,
                title: playingSong.title,
                isMiniPlayer: false);
          }
        });
  }

  Widget playMiniPlayer(
      {required String songID,
      required String album,
      required String artist,
      required String title}) {
    return Container(
      height: 100,
      child: Player(
          url: songID,
          title: title,
          artist: artist,
          album: album,
          isMiniPlayer: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal,
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: songList.length,
                      itemBuilder: (context, index) {
                        var title = songList[index].title;
                        var subtitle = songList[index].artistName;
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 8.0, left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: ListTile(
                            visualDensity: const VisualDensity(vertical: -3),
                            key: ValueKey(songList[index]),
                            // to compact
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: songList[index].starred
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      songList[index].starred
                                          ? UnstarItem(
                                                  id: SongId(
                                                      songId:
                                                          songList[index].id))
                                              .run(widget.subSonicContext)
                                          : StarItem(
                                                  id: SongId(
                                                      songId:
                                                          songList[index].id))
                                              .run(widget.subSonicContext);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.play_arrow_rounded),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      shouldPlay = true;
                                      playingSong = PlayingSong(
                                          songID: songList[index].id,
                                          url: StreamItem(
                                                  songList[index].id.toString(),
                                                  streamFormat:
                                                      StreamFormat.mp3)
                                              .getDownloadUrl(
                                                  widget.subSonicContext),
                                          title: songList[index].title,
                                          artist: songList[index].artistName,
                                          album: songList[index].albumName,
                                          isMiniPlayer: true);
                                    });
                                  },
                                ),
                                PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Color.fromARGB(255, 253, 253, 253),
                                  ),
                                  color: contextMenuColor,
                                  onSelected: (value) => handleClick(value),
                                  itemBuilder: (BuildContext context) {
                                    return {
                                      'Add to Playlist',
                                      'Go to album',
                                      'Go to Artist',
                                      'Show Credits',
                                      'Share'
                                    }.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                  offset: const Offset(0, 40),
                                )
                              ],
                            ),
                            textColor: const Color.fromARGB(204, 11, 170, 14),
                            title: Text(
                              title,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Text(
                              subtitle,
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.0,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            leading: albumArt(songList[index]),
                            onTap: () {
                              // await player.pause();
                              setState(() {
                                shouldPlay = true;
                                debugPrint('should Play $shouldPlay');
                                playingSong = PlayingSong(
                                    songID: songList[index].id,
                                    url: StreamItem(
                                            songList[index].id.toString(),
                                            streamFormat: StreamFormat.mp3)
                                        .getDownloadUrl(widget.subSonicContext),
                                    title: songList[index].title,
                                    artist: songList[index].artistName,
                                    album: songList[index].albumName,
                                    isMiniPlayer: false);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            shouldPlay ? player(playingSong!) : const SizedBox.shrink()
          ],
        ));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Add to Playlist':
        break;
      case 'Go to album':
        break;
      case 'Go to Artist':
        break;
      case 'Show Credits':
        break;
      case 'Share':
        break;
    }
  }
}
