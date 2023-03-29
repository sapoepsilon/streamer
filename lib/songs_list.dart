import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:streamer/player.dart';
import 'package:streamer/subsonic/requests/download.dart';
import 'package:streamer/subsonic/requests/get_album.dart';
import 'package:streamer/subsonic/requests/requests.dart';
import 'package:streamer/subsonic/requests/star.dart';
import 'package:streamer/subsonic/requests/stream_id.dart';
import 'package:streamer/subsonic/subsonic.dart';
import 'package:streamer/utils/utils.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key, required this.subSonicContext});

  final SubsonicContext subSonicContext;

  @override
  State<SongsList> createState() => _SongsList();
}

class _SongsList extends State<SongsList> {
  List<SongResult> songList = [];

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

  Future<void> play(
      String songID, String album, String artist, String title) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Player(
          url: songID,
          key: null,
          album: album,
          artist: artist,
          title: title,
          ctx: widget.subSonicContext,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.black,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: songList.length,
          itemBuilder: (context, index) {
            var title = songList[index].title;
            var subtitle = songList[index].artistName;
            return Container(
              margin: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
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
                      icon: const Icon(Icons.download),
                      color: Colors.white,
                      onPressed: () {
                        DownloadItem(songList[index].id)
                            .run(widget.subSonicContext);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color:
                            songList[index].starred ? Colors.red : Colors.white,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          songList[index].starred
                              ? UnstarItem(
                                      id: SongId(songId: songList[index].id))
                                  .run(widget.subSonicContext)
                              : StarItem(id: SongId(songId: songList[index].id))
                                  .run(widget.subSonicContext);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
                textColor: const Color.fromARGB(204, 11, 170, 14),
                title: Text(
                  title,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                      overflow: TextOverflow.ellipsis),
                ),
                leading: albumArt(songList[index]),
                onTap: () async {
                  // await player.pause();
                  final streamURL = StreamItem(songList[index].id.toString(),
                          streamFormat: StreamFormat.mp3)
                      .getDownloadUrl(widget.subSonicContext);
                  final artist = songList[index].artistName;
                  final album = songList[index].albumName;
                  final title = songList[index].title;
                  play(streamURL, album, artist, title);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
