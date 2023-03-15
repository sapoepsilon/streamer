import 'package:flutter/material.dart';
import 'package:streamer/subsonic/requests/star.dart';
import 'package:streamer/subsonic/subsonic.dart';

class HeartIconButton extends StatefulWidget {
  final String playlistID;
  final SubsonicContext ctx;

  const HeartIconButton(
      {super.key, required this.playlistID, required this.ctx});
  @override
  _HeartIconButtonState createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorited ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 40,
      ),
      onPressed: _toggleFavorite,
    );
  }
}

class ContainerWithHeartButton extends StatefulWidget {
  final Widget playlistImage;
  final String playlistID;
  final SubsonicContext ctx;

  const ContainerWithHeartButton(
      {super.key,
      required this.playlistImage,
      required this.playlistID,
      required this.ctx});

  @override
  _ContainerWithHeartButtonState createState() =>
      _ContainerWithHeartButtonState();
}

class _ContainerWithHeartButtonState extends State<ContainerWithHeartButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.playlistImage,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 10,
            child:
                HeartIconButton(ctx: widget.ctx, playlistID: widget.playlistID),
          ),
        ],
      ),
    );
  }
}
