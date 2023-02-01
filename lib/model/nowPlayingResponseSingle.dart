// To parse this JSON data, do
//
//     final nowPlayingMultiple = nowPlayingMultipleFromJson(jsonString);

import 'dart:convert';

import 'package:streamer/model/nowPlayingResponse.dart';

NowPlayingMultiple nowPlayingMultipleFromJson(String str) => NowPlayingMultiple.fromJson(json.decode(str));

String nowPlayingMultipleToJson(NowPlayingMultiple data) => json.encode(data.toJson());

class NowPlayingMultiple {
  NowPlayingMultiple({
    required this.subsonicResponse,
  });

  SubsonicResponse subsonicResponse;

  factory NowPlayingMultiple.fromJson(Map<String, dynamic> json) {
    return NowPlayingMultiple(
      subsonicResponse: SubsonicResponse.fromJson(json["subsonic-response"]),
    );
  }

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
  NowPlaying nowPlaying;

  factory SubsonicResponse.fromJson(Map<String, dynamic> json) => SubsonicResponse(
    status: json["status"],
    version: json["version"],
    type: json["type"],
    serverVersion: json["serverVersion"],
    xmlns: json["xmlns"],
    nowPlaying: NowPlaying.fromJson(json["nowPlaying"]),
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

class NowPlaying {
  NowPlaying({
    required this.entry,
  });

  List<Entry> entry;

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
    entry: List<Entry>.from(json["entry"].map((x) => Entry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "entry": List<dynamic>.from(entry.map((x) => x.toJson())),
  };
}