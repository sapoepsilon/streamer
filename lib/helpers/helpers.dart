import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../subsonic/requests/get_album.dart';
import '../utils/utils.dart';

InputDecoration loginTextDecoration(String hintText) {
  return InputDecoration(
    border: InputBorder.none,
    contentPadding: const EdgeInsets.only(top: 14),
    prefixIcon: const Icon(
      Icons.perm_contact_cal,
      color: Color(0xFFA51C1C),
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color.fromARGB(156, 255, 255, 255),
    ),
  );
}

bool shouldPlay = false;

BoxDecoration loginTextFieldBackground() {
  return BoxDecoration(
      color: const Color.fromRGBO(0, 0, 0, .5),
      borderRadius: BorderRadius.circular(45),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
      ]);
}

String makeToken(String password, String salt) =>
    md5.convert(utf8.encode(password + salt)).toString().toLowerCase();

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}

Future showErrorDialog(BuildContext context, String errorMessage) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text('An error has occurred $errorMessage'),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
FutureBuilder albumArt(SongResult song) {
  return FutureBuilder(
    future: getImageData(song),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return snapshot.data as Widget;
      } else {
        return const Icon(
          Icons.question_mark_outlined,
          color: Colors.grey,
          size: 24.0,
        );
      }
    },
  );
}

Future<Widget> getImageData(SongResult song) async {
  String songURL =
      await getSongCoverFromITunes(song.artistName, song.title) ?? "";
  if (songURL == "") {
    return const Icon(
      Icons.question_mark_outlined,
      color: Colors.grey,
      size: 24.0,
    );
  } else {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Image.network(
          songURL,
          fit: BoxFit.fill,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
