// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String subsonicUrl = '';
  String username = '';
  String password = '';

  String makeToken(String password, String salt) =>
      md5.convert(utf8.encode(password + salt)).toString().toLowerCase();

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void _connectToServer() async {
    String random = generateRandomString(7);
    String token = makeToken(password, random);

    const id = 'ab';

    final folder = await http.get(Uri.parse(
        'http://$subsonicUrl/rest/ping.view?u=$username&t=$token&s=$random&v=1.61.0&c=streamer'));

    print("request: ${folder.request}");
    print("Server response: ${folder.request}");

    if (folder.statusCode == 200) {
      final Xml2Json xml2json = Xml2Json();
      xml2json.parse(utf8.decode(folder.bodyBytes));
      final json = xml2json.toGData();
      final nowPlaying = json;
      print("now playing: $nowPlaying");
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
  }

  SizedBox localPadding() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter some text..."),
              ),
            ),
            localPadding(),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Username",
                  ),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  }),
            ),
            localPadding(),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: TextField(
                  decoration: const InputDecoration(
                    hintText: "password",
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  }),
            ),
            localPadding(),
            ElevatedButton(
                onPressed: _connectToServer,
                child: const Text("Connect To Server"))
          ],
        ),
      ),
    );
  }
}
