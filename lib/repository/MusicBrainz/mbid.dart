import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<String?> fetchMBID(String releaseTitle, String artistName) async {
  final endpointUrl = "https://musicbrainz.org/ws/2/recording";

  final response = await http.get(Uri.parse(
      "$endpointUrl?query=$releaseTitle%20AND%20artist:$artistName&fmt=json"));

  print("request: ${response.request}");
  if (response.statusCode == 200) {
    final recordings = json.decode(response.body)["recordings"];
    if (recordings != null) {
      final release = recordings[0]["releases"];

      final mbid = release[0]["id"];
      await fetchAlbumArtURL(mbid);
      print("MBID: $mbid");
      return mbid;
    } else {
      print("No release found with the title $releaseTitle by $artistName");
    }
  } else {
    print("Failed to search for release: ${response.statusCode}");
  }
}

Future<String?> fetchAlbumArtURL(String releaseId) async {
  final endpointUrl = "https://coverartarchive.org/release/$releaseId";

  final response = await http.get(Uri.parse(endpointUrl));
  if (response.statusCode == 200) {
    final images = json.decode(response.body);
    if (images != null) {
      final imageUrl = images["images"][0]["thumbnails"]["500"];
      print("Album Art URL: $imageUrl");
      return imageUrl;
    } else {
      print("No album art found for release $releaseId");
    }
  } else {
    print("Failed to fetch album art: ${response.statusCode}");
  }
}
