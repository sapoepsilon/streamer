// To parse this JSON data, do
//
//     final nowPlaying = nowPlayingFromJson(jsonString);

import 'dart:convert';

NowPlaying nowPlayingFromJson(String str) => NowPlaying.fromJson(json.decode(str));

String nowPlayingToJson(NowPlaying data) => json.encode(data.toJson());

class NowPlaying {
  NowPlaying({
    required this.subsonicResponse,
  });

  SubsonicResponse subsonicResponse;

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
    subsonicResponse: SubsonicResponse.fromJson(json["subsonic-response"]),
  );

  Map<String, dynamic> toJson() => {
    "subsonic-response": subsonicResponse.toJson(),
  };
}

class SubsonicResponse {
  SubsonicResponse({
    required this.status,
    required this.version,
    required this.type,
    required this.serverVersion,
    required this.xmlns,
    required this.nowPlaying,
  });

  String status;
  String version;
  String type;
  String serverVersion;
  String xmlns;
  NowPlayingClass nowPlaying;

  factory SubsonicResponse.fromJson(Map<String, dynamic> json) => SubsonicResponse(
    status: json["status"],
    version: json["version"],
    type: json["type"],
    serverVersion: json["serverVersion"],
    xmlns: json["xmlns"],
    nowPlaying: NowPlayingClass.fromJson(json["nowPlaying"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "version": version,
    "type": type,
    "serverVersion": serverVersion,
    "xmlns": xmlns,
    "nowPlaying": nowPlaying.toJson(),
  };
}

class NowPlayingClass {
  NowPlayingClass({
    required this.entry,
  });

  Entry entry;

  factory NowPlayingClass.fromJson(Map<String, dynamic> json) => NowPlayingClass(
    entry: Entry.fromJson(json["entry"]),
  );

  Map<String, dynamic> toJson() => {
    "entry": entry.toJson(),
  };
}

class Entry {
  Entry({
    required this.id,
    required this.parent,
    required this.isDir,
    required this.title,
    required this.album,
    required this.artist,
    required this.track,
    required this.year,
    required this.genre,
    required this.coverArt,
    required this.size,
    required this.contentType,
    required this.suffix,
    required this.duration,
    required this.bitRate,
    required this.path,
    required this.discNumber,
    required this.created,
    required this.albumId,
    required this.type,
    required this.isVideo,
    required this.username,
    required this.minutesAgo,
    required this.playerId,
    required this.playerName,
  });

  String id;
  String parent;
  String isDir;
  String title;
  String album;
  String artist;
  String track;
  String year;
  String genre;
  String coverArt;
  String size;
  String contentType;
  String suffix;
  String duration;
  String bitRate;
  String path;
  String discNumber;
  DateTime created;
  String albumId;
  String type;
  String isVideo;
  String username;
  String minutesAgo;
  String playerId;
  String playerName;

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    id: json["id"],
    parent: json["parent"],
    isDir: json["isDir"],
    title: json["title"],
    album: json["album"],
    artist: json["artist"],
    track: json["track"],
    year: json["year"],
    genre: json["genre"],
    coverArt: json["coverArt"],
    size: json["size"],
    contentType: json["contentType"],
    suffix: json["suffix"],
    duration: json["duration"],
    bitRate: json["bitRate"],
    path: json["path"],
    discNumber: json["discNumber"],
    created: DateTime.parse(json["created"]),
    albumId: json["albumId"],
    type: json["type"],
    isVideo: json["isVideo"],
    username: json["username"],
    minutesAgo: json["minutesAgo"],
    playerId: json["playerId"],
    playerName: json["playerName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent": parent,
    "isDir": isDir,
    "title": title,
    "album": album,
    "artist": artist,
    "track": track,
    "year": year,
    "genre": genre,
    "coverArt": coverArt,
    "size": size,
    "contentType": contentType,
    "suffix": suffix,
    "duration": duration,
    "bitRate": bitRate,
    "path": path,
    "discNumber": discNumber,
    "created": created.toIso8601String(),
    "albumId": albumId,
    "type": type,
    "isVideo": isVideo,
    "username": username,
    "minutesAgo": minutesAgo,
    "playerId": playerId,
    "playerName": playerName,
  };
}

