import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Player extends StatefulWidget {
  final String url;

  const Player({Key? key, required this.url})
      : super(key: key);

  @override
  _Player createState() => _Player();
}

class _Player extends State<Player> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _scrollController = ScrollController();
  }

  void _play() async {
    log("url: ${widget.url}");
      final duration = await _audioPlayer.setUrl("https://wpr-ice.streamguys1.com/wpr-ideas-mp3-64");


    try {
      await _audioPlayer.play();
    } catch (e) {
      log("error while playing: $e");
    }
  }

  void _pause() async {
  await _audioPlayer.pause();
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
