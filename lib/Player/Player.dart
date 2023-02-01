import 'dart:convert';
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:streamer/Player/SeekBar.dart';
import 'package:streamer/helpers/helpers.dart';
import 'package:rxdart/rxdart.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:http/http.dart' as http;

import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with QueueHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler(String url) {
    String random = generateRandomString(7);

    print("new play---------------------------- \n\n\n\n\n\n\n\n\n\n");
    print("URl address of the song is: $url");
    final token = makeToken("Faridonaka48@", random);
    _player.setUrl(url);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();
}

class Player extends StatefulWidget {
  final String url;
  final String serverURL;
  final String songID;
  final String albumName;
   bool? isImageFetched = false;
  Image? albumArtImage;

   Player(
      {Key? key,
      required this.url,
      required this.serverURL,
      required this.songID, required this.albumName})
      : super(key: key);

  @override
  _Player createState() => _Player();
}

class _Player extends State<Player> {
  String albumArtURL = "";

  String imageURL = "";
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  late ScrollController _scrollController;
  late AudioPlayerHandler _audioHandler;
  Duration _duration = Duration();
  Duration _position = Duration();

  void getURL() async {
    setState(() async {
      albumArtURL = await _fetchAlbumArt();
      widget.albumArtImage = Image.network(albumArtURL);
      widget.isImageFetched = true;
    });
  }
  @override
  void initState() {
    super.initState();
    _audioHandler = AudioPlayerHandler(widget.url);
    _scrollController = ScrollController();
    getURL();
  }


  void _play() async {
    _audioHandler.play();
    setState(() {
      _isPlaying = true;
      _duration = _audioHandler._player.duration!;
      _position = _audioHandler._player.position;
    });
  }

  void _pause() async {
    await _audioHandler.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while playing the audio.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<MediaItem?>(
                stream: _audioHandler.mediaItem,
                builder: (context, snapshot) {
                  final mediaItem = snapshot.data;
                  return Text(mediaItem?.title ?? '');
                },
              ),
             widget.isImageFetched! ? SizedBox(height: 200,child:FittedBox(
                fit: BoxFit.fill,
                child: widget.albumArtImage!,
              ),)  : const SizedBox.shrink(),
              _isPlaying
                  ? IconButton(
                      icon:const Icon(Icons.pause),
                      onPressed: _pause,
                    )
                  : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: _play,
                    ),
              // A seek bar.
              StreamBuilder<MediaState>(
                stream: _mediaStateStream,
                builder: (context, snapshot) {
                  final mediaState = snapshot.data;
                  return SeekBar(
                    duration: _duration ?? Duration.zero,
                    position: _position ?? Duration.zero,
                    onChangeEnd: (newPosition) {
                      print("new position: $newPosition");
                      _audioHandler._player.seek((newPosition ?? _position));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> get _mediaStateStream =>
      Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          _audioHandler.mediaItem,
          AudioService.position,
          (mediaItem, position) => MediaState(mediaItem, position));

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    _audioHandler._player.seek(newDuration);
  }

  Widget albumArt() {
    return Image.network(imageURL);
  }

    Future<String> _fetchAlbumArt() async {
    String imageURL = "";
    print("widget album name: ${widget.albumName}");
    final response = await http.get(Uri.parse(
        'https://itunes.apple.com/search?term=${widget.albumName}&entity=album'));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['resultCount'] > 0) {
        final firstResult = result['results'][0];
        print("album art $firstResult");
          debugPrint(firstResult['artworkUrl100']);
          imageURL = firstResult['artworkUrl100'];
      }
    }
    return imageURL;
  }

  Widget slider() {
    AudioService.position.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });

    return Slider(
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}
