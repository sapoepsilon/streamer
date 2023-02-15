// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:just_audio/just_audio.dart';

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

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _scrollController = ScrollController();
  }

  void _play() async {
    await _audioPlayer.setUrl(widget.url);
    try {
      setState(() {});
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
    return PlatformAppBar(
      title: const Text('Music Player'),
      cupertino: (context, platform) {
        return CupertinoNavigationBarData(
            leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isPlaying
                ? PlatformElevatedButton(
                    child: const Icon(CupertinoIcons.pause),
                    onPressed: _pause,
                  )
                : PlatformElevatedButton(
                    child: const Icon(CupertinoIcons.play),
                    onPressed: _play,
                  ),
          ],
        ));
      },
      material: (context, platform) {
        return MaterialAppBarData(
            leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isPlaying
                ? IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: (() {
                      _isPlaying = !_isPlaying;
                      _pause();
                    }),
                  )
                : IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: (() {
                      _isPlaying = !_isPlaying;
                      _play();
                    })),
          ],
        ));
      },
    );
  }
}
