import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streamer/Home.dart';
import 'package:streamer/helpers/helpers.dart';
import 'package:streamer/model/getArtistsResponse.dart';
import 'package:streamer/model/nowPlayingResponse.dart';
import 'package:xml2json/xml2json.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String _name = "";
  String _server = "";
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                  colors: [
                    Colors.teal,
                    Colors.black,
                  ],
                  radius: .8,
                )),
                child: SingleChildScrollView(
                  // physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Streamer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 130),
                      server(),
                      const SizedBox(height: 20),
                      name(),
                      const SizedBox(height: 20),
                      username(),
                      const SizedBox(height: 20),
                      password(),
                      const SizedBox(height: 70),
                      conect()
                      // buildforgotPassBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget server() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _server = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: loginTextDecoration("123.456.789.123"),
          ),
        )
      ],
    );
  }

  Widget password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: loginTextDecoration("Password"),
          ),
        )
      ],
    );
  }

  Widget name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: loginTextDecoration("Name")),
        )
      ],
    );
  }

  Widget username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: loginTextDecoration("Username"),
          ),
        )
      ],
    );
  }

  Widget conect() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _connectToServer,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(80, 60),
            backgroundColor: Colors.purple.shade900,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45))),
        child: const Text(
          "Conect",
          style: TextStyle(
            color: Color.fromARGB(222, 24, 167, 214),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _connectToServer() async {
    String random = generateRandomString(7);
    String token = makeToken(_password, random);

    const id = 'ab';

    final folder = await http.get(Uri.parse(
        'http://$_server/rest/getArtists.view?u=$_username&t=$token&s=$random&v=1.61.0&c=streamer'));

    print("request: ${folder.request}");
    print("Server response: ${folder.request}");

    if (folder.statusCode == 200) {
      final Xml2Json xml2json = Xml2Json();
      xml2json.parse(utf8.decode(folder.bodyBytes));
      final json = xml2json.toGData();
      final nowPlayingResponse = json;
      print("Get artists json: $nowPlayingResponse");
      late GetArtists getArtists;
      try {
        getArtists = getArtistsFromJson(nowPlayingResponse);
      } catch (e) {
        print("error parsing nowplaying $e");
      }

      if (getArtists != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(getArtists: getArtists)));
      } else {
        print("now playing is null");
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
  }
}
