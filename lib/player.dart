// ignore_for_file: library_private_types_in_public_api

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
  final bool _isPlaying = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _scrollController = ScrollController();
  }

  void _play() async {
    log("url: ${widget.url}");

    try {
      await _audioPlayer.play();
    } catch (e) {
      log("error while playing: $e");
    }
  }

  void _pause() async {
  await _audioPlayer.pause();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isPlaying
                  ? IconButton(
                      icon: const Icon(Icons.pause),
                      onPressed: _pause,
                    )
                  : IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: _play,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
