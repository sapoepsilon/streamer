import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamer/helpers/custom_models/credentials_model.dart';

// Saving credentials
void saveCredentials(Credentials credentials) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customModelJson = jsonEncode(credentials.toJson());
  prefs.setString("credentials_${credentials.name}", customModelJson);
}

// Retrieving credentials
Future<List<Credentials>?> getCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Iterable<String> keys =
      prefs.getKeys().where((key) => key.startsWith('credentials_'));
  List<String?> retrievedValues = [];

  for (String key in keys) {
    String? customModelJson = prefs.getString(key);
    if (customModelJson != null) {
      retrievedValues.add(customModelJson);
    }
  }
  if (retrievedValues == []) {
    return null;
  }

  List<Credentials> credentials = [];
  for (String? customModelJson in retrievedValues) {
    credentials.add(Credentials.fromJson(jsonDecode(customModelJson!)));
  }
  return credentials;
}

// save boolean
void saveUser(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

// retrieve boolean
Future<bool> getBool(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}
