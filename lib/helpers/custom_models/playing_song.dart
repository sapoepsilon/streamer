class PlayingSong {
  final String songID;
  final String url;
  final String title;
  final String artist;
  final String album;
  final bool isMiniPlayer;

  PlayingSong({
    required this.songID,
    required this.url,
    required this.title,
    required this.artist,
    required this.album,
    required this.isMiniPlayer,
  });
}
