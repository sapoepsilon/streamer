// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:streamer/repository/MusicBrainz/mbid.dart';
import 'package:streamer/subsonic/requests/get_album.dart';

class Player extends StatefulWidget {
  final String url;
  final String title;
  final String artist;
  final String album;
  final int songIndex;
  final List<SongResult> songList;

  const Player(
      {Key? key,
      required this.url,
      required this.title,
      required this.artist,
      required this.album,
      required this.songIndex,
      required this.songList})
      : super(key: key);

  @override
  _Player createState() => _Player();
}

class _Player extends State<Player> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  late ScrollController _scrollController;
  String songURL = "";
  bool isAlbumArtLoading = true;

  late int initializedSongIndex;
  late int nextSongIndex;
  late int previousSongIndex;

  @override
  void initState() {
    super.initState();
    initializedSongIndex = widget.songIndex;
    nextSongIndex = initializedSongIndex + 1;
    previousSongIndex = initializedSongIndex - 1;
    _setSong(widget.url);
    _play();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    super.dispose();
  }

  void _setSong(String url) async {
    await _audioPlayer.setUrl(url);
  }

  void _play() async {
    try {
      setState(() {
        _isPlaying = true;
      });
      await _audioPlayer.play();
    } catch (e) {
      log("error while playing: $e");
    }
  }

  void _playNextSong(String songURL) {
    if (initializedSongIndex != widget.songList.length) {
      initializedSongIndex = nextSongIndex;
      nextSongIndex = nextSongIndex + 1;
    } else {
      initializedSongIndex = 0;
      nextSongIndex = 1;
    }
    _setSong(songURL);
  }

  void _playPreviousSong(String songURL) {
    if (initializedSongIndex != widget.songList.length) {
      initializedSongIndex = nextSongIndex;
      nextSongIndex = nextSongIndex - 1;
    } else {
      initializedSongIndex = widget.songList.length;
      nextSongIndex = widget.songList.length - 1;
    }
    _setSong(songURL);
  }

  void _pause() async {
    await _audioPlayer.pause();
  }

  Future<Widget> getImageData() async {
    String mbid = await fetchMBID(widget.album, widget.artist) ?? "";
    songURL = await fetchAlbumArtURL(mbid) ?? "";
    if (songURL != "") {
      isAlbumArtLoading = false;
    }
    if (songURL == "") {
      return const Icon(
        Icons.question_mark_outlined,
        color: Colors.grey,
        size: 24.0,
      );
    } else {
      return Image.network(songURL);
    }
  }

  FutureBuilder albumArt() {
    return FutureBuilder(
      future: getImageData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              // LoadingAnimationwidget that call the
              color: Colors.green, // staggereddotwave animation
              size: 50,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black,
            Colors.teal,
          ]),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Padding(padding: EdgeInsets.all(16.0)),
          // Album cover
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                child: albumArt(),
              ),
            ),
          ),

          // Song title and artist
          Column(
            children: [
              PlatformText(
                widget.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
              PlatformText(
                widget.artist,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),

          // Seeker
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 30,
                child: StreamBuilder<Duration>(
                  stream: _audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    Duration progress = snapshot.data ?? const Duration();
                    return PlatformSlider(
                      activeColor: Colors.purple,
                      value: progress.inMilliseconds.toDouble(),
                      onChangeEnd: (double value) {
                        _audioPlayer
                            .seek(Duration(milliseconds: value.toInt()));
                      },
                      min: 0.0,
                      max: _audioPlayer.duration?.inMilliseconds.toDouble() ??
                          3.0,
                      onChanged: (value) {},
                    );
                  },
                ),
              ),
              Container(
                child: StreamBuilder<Duration>(
                    stream: _audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      Duration progress = snapshot.data ?? const Duration();

                      String sDuration =
                          "${_audioPlayer.duration?.inMinutes.remainder(60)}:${(_audioPlayer.duration?.inSeconds.remainder(60))}";
                      return Text(
                        "${progress.inMinutes.remainder(60)}: ${progress.inSeconds.remainder(60)} / $sDuration",
                        style: const TextStyle(color: Colors.white),
                      );
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: PlatformIconButton(
                  materialIcon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                  cupertinoIcon: const Icon(
                    CupertinoIcons.backward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _playPreviousSong(widget.songList[nextSongIndex].playUrl);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: PlatformElevatedButton(
                  material: (context, platform) {
                    return MaterialElevatedButtonData(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal),
                          shape: MaterialStateProperty.all<CircleBorder>(
                              const CircleBorder())),
                    );
                  },
                  cupertino: (context, platform) {
                    return CupertinoElevatedButtonData(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(60),
                    );
                  },
                  color: Colors.teal,
                  child: _isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                  onPressed: () {
                    _isPlaying ? _pause() : _play();
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: PlatformIconButton(
                  materialIcon: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                  cupertinoIcon: const Icon(
                    CupertinoIcons.forward_end_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _playNextSong(widget.songList[nextSongIndex].playUrl);
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
