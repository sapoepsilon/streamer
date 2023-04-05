import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<String?> fetchMBID(String releaseTitle, String artistName) async {
  const endpointUrl = "https://musicbrainz.org/ws/2/recording";

  final response = await http.get(Uri.parse(
      "$endpointUrl?query=$releaseTitle%20AND%20artist:$artistName&fmt=json"));

  debugPrint("request: ${response.request}");
  if (response.statusCode == 200) {
    final recordings = json.decode(response.body)["recordings"];
    if (recordings != null) {
      final release = recordings[0]["releases"];

      final mBid = release[0]["id"];
      await fetchAlbumArtURL(mBid);
      debugPrint("MBID: $mBid");
      return mBid;
    } else {
      debugPrint("No release found with the title $releaseTitle by $artistName");
    }
  } else {
    debugPrint("Failed to search for release: ${response.statusCode}");
  }
  return null;
}

Future<String?> fetchAlbumArtURL(String releaseId) async {
  final endpointUrl = "https://coverartarchive.org/release/$releaseId";

  final response = await http.get(Uri.parse(endpointUrl));
  if (response.statusCode == 200) {
    final images = json.decode(response.body);
    if (images != null) {
      final imageUrl = images["images"][0]["thumbnails"]["500"];
      debugPrint("Album Art URL: $imageUrl");
      return imageUrl;
    } else {
      debugPrint("No album art found for release $releaseId");
    }
  } else {
    debugPrint("Failed to fetch album art: ${response.statusCode}");
  }
  return null;
}
