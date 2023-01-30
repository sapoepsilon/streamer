import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:streamer/helpers/helpers.dart';

import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler(String url) {
    String random = generateRandomString(7);

    print("new play---------------------------- \n\n\n\n\n\n\n\n\n\n");

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

  const Player({Key? key, required this.url}) : super(key: key);

  @override
  _Player createState() => _Player();
}

class _Player extends State<Player> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  late ScrollController _scrollController;
  late AudioPlayerHandler _audioHandler;

  @override
  void initState() {
    super.initState();
    _audioHandler = AudioPlayerHandler(widget.url);
    _scrollController = ScrollController();
  }

  void _play() async {
    _audioHandler.play();
    setState(() {
      _isPlaying = true;
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
              _isPlaying
                  ? IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: _pause,
                    )
                  : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: _play,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
