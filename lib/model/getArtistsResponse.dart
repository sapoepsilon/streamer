// To parse this JSON data, do
//
//     final getArtists = getArtistsFromJson(jsonString);

import 'dart:convert';

GetArtists getArtistsFromJson(String str) => GetArtists.fromJson(json.decode(str));

String getArtistsToJson(GetArtists data) => json.encode(data.toJson());

class GetArtists {
    GetArtists({
        required this.subsonicResponse,
    });

    SubsonicResponse subsonicResponse;

    factory GetArtists.fromJson(Map<String, dynamic> json) => GetArtists(
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
        required this.artists,
    });

    String status;
    String version;
    String type;
    String serverVersion;
    String xmlns;
    Artists artists;

    factory SubsonicResponse.fromJson(Map<String, dynamic> json) => SubsonicResponse(
        status: json["status"],
        version: json["version"],
        type: json["type"],
        serverVersion: json["serverVersion"],
        xmlns: json["xmlns"],
        artists: Artists.fromJson(json["artists"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "version": version,
        "type": type,
        "serverVersion": serverVersion,
        "xmlns": xmlns,
        "artists": artists.toJson(),
    };
}

class Artists {
    Artists({
        required this.lastModified,
        required this.ignoredArticles,
        required this.index,
    });

    String lastModified;
    String ignoredArticles;
    List<Index> index;

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        lastModified: json["lastModified"],
        ignoredArticles: json["ignoredArticles"],
        index: List<Index>.from(json["index"].map((x) => Index.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lastModified": lastModified,
        "ignoredArticles": ignoredArticles,
        "index": List<dynamic>.from(index.map((x) => x.toJson())),
    };
}

class Index {
    Index({
        required this.name,
        required this.artist,
    });

    String name;
    Artist artist;

    factory Index.fromJson(Map<String, dynamic> json) => Index(
        name: json["name"],
        artist: Artist.fromJson(json["artist"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "artist": artist.toJson(),
    };
}

class Artist {
    Artist({
        required this.id,
        required this.name,
        required this.albumCount,
    });

    String id;
    String name;
    String albumCount;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        albumCount: json["albumCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "albumCount": albumCount,
    };
}
